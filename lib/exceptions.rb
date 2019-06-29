module Exceptions
  class ManagerNotFoundException < StandardError
    def initialize(msg = "Manager not found in the system")
      super
    end
  end

  class CompanyNotFoundException < StandardError
    def initialize(msg = "Company does not exist")
      super
    end
  end
end