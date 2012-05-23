require File.dirname(__FILE__) + '/test_case'

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
  end
end
