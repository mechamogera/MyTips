require File.expand_path('test_case', File.dirname(__FILE__))

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
    
    test "should not update because of invalid id" do
      user = User.first
      sign_in user
      put :update, id: 'test', report: { body: 'ccc', title: 'ddd' }
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
    
    test "should not update because of invalid owner" do
      sign_in users(:two)
      put :update, id: @report, report: { body: 'ccc', title: 'ddd' }
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
  end
end
