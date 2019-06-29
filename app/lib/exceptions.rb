module Exceptions
  class ManagerNotFoundException < StandardError
    def initialize(msg = "Manager not found in the system")
      super
    end
  end
end