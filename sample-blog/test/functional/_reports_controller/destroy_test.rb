require File.expand_path('test_case', File.dirname(__FILE__))

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should destroy report" do
      sign_in User.first
      assert_difference('Report.count', -1) do
        delete :destroy, id: @report
      end

      assert_redirected_to reports_path
    end

    test "shoudl not destroy report" do
      assert_raise(ArgumentError) do
        delete :destroy, id: @report
      end
    end
    
    test "should not destroy report because of invalid id" do
      sign_in User.first
      assert_no_difference('Report.count') do
        delete :destroy, id: 'test'
      end
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
    
    test "should not destroy report because of invalid owner" do
      sign_in users(:two)
      assert_no_difference('Report.count') do
        delete :destroy, id: @report
      end
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
  end
end
