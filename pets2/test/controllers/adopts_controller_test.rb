require 'test_helper'

class AdoptsControllerTest < ActionController::TestCase
  setup do
    @adopt = adopts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adopts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adopt" do
    assert_difference('Adopt.count') do
      post :create, adopt: { pet_id: @adopt }
    end

    assert_redirected_to adopts_url(assigns(:adopt))
  end

  test "should show adopt" do
    get :show, id: @adopt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adopt
    assert_response :success
  end

  test "should update adopt" do
    patch :update, id: @adopt, adopt: { pet_id: @adopt.pet_id }
    assert_redirected_to adopt_path(assigns(:adopt))
  end

  test "should destroy adopt" do
    assert_difference('Adopt.count', -1) do
      delete :destroy, id: @adopt
    end

    assert_redirected_to adopts_path
  end
end
