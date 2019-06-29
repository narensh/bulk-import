module ImportsHelper
include Exceptions
  # move to configuration
  BATCH_SIZE = 100

  class << self
    def create_imports(request_id, params)
      records = []
      CSV.foreach(params[:file].path, headers: true) do |row|
        records << {request_id: request_id, employee_name: row[0], email: row[1],
                    phone: row[2].try(:gsub, /[^0-9A-Za-z]/, ''),
                    report_to: row[3], assigned_policies: row[4], company_id: params[:company_id],
                    file_name: params[:file].original_filename}
      end
      Import.create(records)
    end

    def process(request_id)
      process_in_batches(request_id, ImportStatus::NOT_STARTED) do |requests|
        policies = process_policies(requests)
        mark_in_progress(requests)
        requests.each do |request|
          begin
            status = request.report_to.blank? ? ImportStatus::COMPLETED : ImportStatus::MANAGER_ASSIGNMENT_PENDING
            EmployeesHelper.create_employee(request, policies)
          rescue ActiveRecord::RecordInvalid => e
            message = e.message
          end
          request.update(status: message.blank? ? status : ImportStatus::ERROR, message: message)
        end
      end
      assign_managers(request_id)
    end

    def assign_managers(request_id)
      process_in_batches(request_id, ImportStatus::MANAGER_ASSIGNMENT_PENDING) do |requests|
        requests.each do |request|
          employee = Employee.find_by_email(request.email)
          begin
            employee.assign_manager(request.report_to)
          rescue ManagerNotFoundException => e
            employee.destroy
            message = e.message
          end

          request.update(status: message.blank? ? ImportStatus::COMPLETED : ImportStatus::ERROR, message: message)
        end
      end
    end

    def process_in_batches(request_id, status)
      Import.where(request_id: request_id, status: status)
          .find_in_batches(batch_size: BATCH_SIZE) do |requests|
        yield(requests)
      end
    end

    def process_policies(requests)
      assigned_policies = []
      assigned_policies << requests.map {|request| PoliciesHelper.names_to_array(request.assigned_policies)}
      assigned_policies.flatten!
      assigned_policies.uniq!
      PoliciesHelper.fetch_or_persist(requests.first.company_id, assigned_policies)
    end

    def mark_in_progress(requests)
      Import.where(id: requests.map(&:id)).update_all(status: ImportStatus::IN_PROGRESS)
    end
  end
end