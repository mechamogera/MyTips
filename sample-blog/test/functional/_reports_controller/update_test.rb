require File.dirname(__FILE__) + '/test_case'

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should update report" do
      user = User.first
      sign_in user
      put :update, id: @report, report: { body: 'ccc', title: 'ddd' }
      assert_redirected_to report_path(assigns(:report))
      assert_equal('ccc', user.reports.first.body)
      assert_equal('ddd', user.reports.first.title)
    end

    test "should not update report without sign_in" do
      assert_raise(ArgumentError) do
        put :update, id: @report, report: { body: @report.body, title: @report.title }
      end
    end
  end
end
