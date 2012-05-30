require File.expand_path('test_case', File.dirname(__FILE__))

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
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
  end
end
