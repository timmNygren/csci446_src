require 'test_helper'

class FosterhomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 2
    assert_select '#main .entry', :minimum => 3
    assert_select 'h3', 'Jimmy'
    assert_select '.age', /\d+/
  end
end
