require 'test_helper'

class Admin::HousesControllerTest < ActionController::TestCase
  setup do
    @admin_house = admin_houses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_house" do
    assert_difference('Admin::House.count') do
      post :create, admin_house: {  }
    end

    assert_redirected_to admin_house_path(assigns(:admin_house))
  end

  test "should show admin_house" do
    get :show, id: @admin_house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_house
    assert_response :success
  end

  test "should update admin_house" do
    put :update, id: @admin_house, admin_house: {  }
    assert_redirected_to admin_house_path(assigns(:admin_house))
  end

  test "should destroy admin_house" do
    assert_difference('Admin::House.count', -1) do
      delete :destroy, id: @admin_house
    end

    assert_redirected_to admin_houses_path
  end
end
