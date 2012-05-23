require File.dirname(__FILE__) + '/test_case'

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should get edit" do
      sign_in User.first
      get :edit, id: @report
      assert_response :success
    end
    
    test "should not get edit without sign_in" do
      assert_raise(ArgumentError) do
        get :edit, id: @report
      end
    end
  end
end
