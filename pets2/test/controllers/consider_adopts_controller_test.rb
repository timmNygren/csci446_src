require 'test_helper'

class ConsiderAdoptsControllerTest < ActionController::TestCase
  setup do
    @consider_adopt = consider_adopts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consider_adopts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consider_adopt" do
    assert_difference('ConsiderAdopt.count') do
      post :create, consider_adopt: pets(:jimmy).id
    end

    assert_redirected_to fosterhome_path
  end

  test "should create consider_adopt via ajax" do
    assert_difference('ConsiderAdopt.count') do
      xhr :post, :create, pet_id: pets(:jimmy).id
    end

    assert_response :success
    assert_select_jquery :html, '#consider' do
      assert_select 'tr#current_pet td', /Jimmy/
    end
  end

  test "should show consider_adopt" do
    get :show, id: @consider_adopt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consider_adopt
    assert_response :success
  end

  test "should update consider_adopt" do
    patch :update, id: @consider_adopt, consider_adopt: { pet_id: @consider_adopt.pet_id }
    assert_redirected_to consider_adopt_path(assigns(:consider_adopt))
  end

  test "should destroy consider_adopt" do
    assert_difference('ConsiderAdopt.count', -1) do
      delete :destroy, id: @consider_adopt
    end

    assert_redirected_to consider_adopts_path
  end
end
