require File.dirname(__FILE__) + '/test_case'

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should update report" do
      sign_in User.first
      put :update, id: @report, report: { body: @report.body, title: @report.title }
      assert_redirected_to report_path(assigns(:report))
    end

    test "should not update report without sign_in" do
      assert_raise(ArgumentError) do
        put :update, id: @report, report: { body: @report.body, title: @report.title }
      end
    end
  end
end
