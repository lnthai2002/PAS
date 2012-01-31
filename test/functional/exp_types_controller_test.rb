require 'test_helper'

class ExpTypesControllerTest < ActionController::TestCase
  setup do
    @exp_type = exp_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exp_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exp_type" do
    assert_difference('ExpType.count') do
      post :create, exp_type: @exp_type.attributes
    end

    assert_redirected_to exp_type_path(assigns(:exp_type))
  end

  test "should show exp_type" do
    get :show, id: @exp_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exp_type.to_param
    assert_response :success
  end

  test "should update exp_type" do
    put :update, id: @exp_type.to_param, exp_type: @exp_type.attributes
    assert_redirected_to exp_type_path(assigns(:exp_type))
  end

  test "should destroy exp_type" do
    assert_difference('ExpType.count', -1) do
      delete :destroy, id: @exp_type.to_param
    end

    assert_redirected_to exp_types_path
  end
end
