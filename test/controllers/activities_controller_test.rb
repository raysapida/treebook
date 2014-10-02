require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  test "should get index" do
		sign_in users(:jason)
    get :index
    assert_response :success
  end

end
