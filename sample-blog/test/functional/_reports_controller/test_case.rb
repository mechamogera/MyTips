require File.dirname(__FILE__) + '/../../test_helper'                                                       

class ActiveSupport::TestCase
    include Devise::TestHelpers
end

class ReportsController::TestCase < ActionController::TestCase

  tests ReportsController

  def setup
  end 

  def teardown
  end 
end

