require 'test_helper'

class RationalesControllerTest < ActionController::TestCase
  setup do
    @rationale = rationales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rationales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rationale" do
    assert_difference('Rationale.count') do
      post :create, rationale: {  }
    end

    assert_redirected_to rationale_path(assigns(:rationale))
  end

  test "should show rationale" do
    get :show, id: @rationale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rationale
    assert_response :success
  end

  test "should update rationale" do
    patch :update, id: @rationale, rationale: {  }
    assert_redirected_to rationale_path(assigns(:rationale))
  end

  test "should destroy rationale" do
    assert_difference('Rationale.count', -1) do
      delete :destroy, id: @rationale
    end

    assert_redirected_to rationales_path
  end
end
