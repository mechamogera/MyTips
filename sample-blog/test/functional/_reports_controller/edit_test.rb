require File.expand_path('test_case', File.dirname(__FILE__))

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
    end

    test "should get edit" do
      sign_in User.first
      get :edit, id: @report
      assert_response :success
    end
    
    test "should not get edit without sign_in" do
      assert_raise(ArgumentError) do
        get :edit, id: @report
      end
    end

    test "should not get edit because of invalid id" do
      sign_in User.first
      get :edit, id: 'test'
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
    
    test "should not get edit because of invalid owner" do
      sign_in users(:two)
      get :edit, id: @report
      assert_response :not_found
      assert_template("error")
      assert_equal("not find request page", assigns(:message))
    end
  end
end
