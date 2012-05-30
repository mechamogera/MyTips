require File.expand_path('test_case', File.dirname(__FILE__))

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

    test "should not create report for nothing title" do
      user = User.first
      sign_in user
      assert_no_difference('Report.count') do
        post :create, report: { body: 'aaa' }
      end

      assert_response(:ok)
      assert_template("new")
      assert_equal(1, assigns(:report).errors.count)
      assert_equal("Title can't be blank", assigns(:report).errors.full_messages.first)
    end
  end
end
