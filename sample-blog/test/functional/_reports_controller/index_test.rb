require File.expand_path('test_case', File.dirname(__FILE__))

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
      assert_equal(Report.count, assigns(:reports).size)
    end
  
    test "should get index without sign_in" do
      get :index
      assert_response :success
      assert_not_nil assigns(:reports)
      assert_equal(Report.count, assigns(:reports).size)
    end

    test "should get index with user_id" do
      get :index, :user_id => User.first.id
      assert_response :success
      assert_not_nil assigns(:reports)
      assert_equal(Report.where(:user_id => User.first.id).count, assigns(:reports).count)
      assigns(:reports).each do |report|
        assert_equal(User.first.id, report.user.id)
      end
    end

    test "should not get index because of invalid user_id" do
      get :index, :user_id => 'test'
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
  end
end
