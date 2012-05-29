require 'test_helper'

class ActiveSupport::TestCase
  include Devise::TestHelpers
end

class ReportsControllerTest < ActionController::TestCase
  self.sub_tests("functional/_reports_controller")
end
