require 'test_helper'

class AdoptControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, pet: pets(:jimmy)
    assert_response :success
  end

end
