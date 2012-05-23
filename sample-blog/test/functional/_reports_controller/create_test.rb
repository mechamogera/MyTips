require File.dirname(__FILE__) + '/test_case'

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

    test "should get new" do
      sign_in User.first
      get :new
      assert_response :success
    end
  
    test "should not get new without sign_in" do
      assert_raise(ArgumentError) do
        get :new
      end
    end

    test "should create report" do
      sign_in User.first
      assert_difference('Report.count') do
        post :create, report: { body: @report.body, title: @report.title }
      end

      assert_redirected_to report_path(assigns(:report))
    end

    test "should show report" do
      sign_in User.first
      get :show, id: @report
      assert_response :success
    end

    test "should show repoart without sign_in" do
      get :show, id: @report
      assert_response :success
    end
  
    test "should get edit" do
      sign_in User.first
      get :edit, id: @report
      assert_response :success
    end

    test "should update report" do
      sign_in User.first
      put :update, id: @report, report: { body: @report.body, title: @report.title }
      assert_redirected_to report_path(assigns(:report))
    end

    test "should destroy report" do
      sign_in User.first
      assert_difference('Report.count', -1) do
        delete :destroy, id: @report
      end

      assert_redirected_to reports_path
    end
  end
end
