require File.dirname(__FILE__) + '/test_case'

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should create report" do
      sign_in User.first
      assert_difference('Report.count') do
        post :create, report: { body: @report.body, title: @report.title }
      end

      assert_redirected_to report_path(assigns(:report))
    end
  end
end
