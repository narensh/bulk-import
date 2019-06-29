class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.string 'request_id', null:false
      t.string 'employee_name'
      t.string 'email'
      t.integer 'phone'
      t.string 'report_to'
      t.string 'assigned_policies'
      t.integer 'company_id'
      t.string 'file_name'
      t.string 'status', default: 'NOT_STARTED'
      t.string 'message'
      t.timestamps
    end
  end
end