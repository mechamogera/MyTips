require File.expand_path('test_case', File.dirname(__FILE__))

class ReportsController
  class CreateTest < TestCase
    setup do
      @report = reports(:one)
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
  end
end
