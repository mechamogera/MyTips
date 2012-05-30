require File.expand_path('test_case', File.dirname(__FILE__))

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should get index" do
      sign_in User.first
      get :index
      assert_response :success
      assert_not_nil assigns(:reports)
    end
  
    test "should get index without sign_in" do
      get :index
      assert_response :success
      assert_not_nil assigns(:reports)
    end
  end
end
