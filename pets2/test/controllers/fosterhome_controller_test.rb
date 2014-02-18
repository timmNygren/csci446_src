require 'test_helper'

class FosterhomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side #link', minimum: 2
    assert_select '#main .entry', 3
    assert_select 'h3', 'Jimmy'
    assert_select '.age', /[\d]+/
  end

  test "markup needed for fosterhome.js.coffee is in place" do
  	get :index
  	assert_select '.fosterhome .entry > img', 3
  	assert_select '.entry input[type=submit]', 3
  end

end
