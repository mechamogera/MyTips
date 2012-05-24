require File.dirname(__FILE__) + '/test_case'

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should create report" do
      user = User.first
      sign_in user
      assert_difference('Report.count') do
        post :create, report: { body: 'aaa', title: 'bbb' }
      end

      assert_redirected_to report_path(assigns(:report))
      assert_equal('aaa', user.reports.last.body)
      assert_equal('bbb', user.reports.last.title)
    end
  end
end
