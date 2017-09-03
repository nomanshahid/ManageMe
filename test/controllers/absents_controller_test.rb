require 'test_helper'

class AbsentsControllerTest < ActionController::TestCase
  setup do
    @absent = absents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:absents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create absent" do
    assert_difference('Absent.count') do
      post :create, absent: { date: @absent.date }
    end

    assert_redirected_to absent_path(assigns(:absent))
  end

  test "should show absent" do
    get :show, id: @absent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @absent
    assert_response :success
  end

  test "should update absent" do
    patch :update, id: @absent, absent: { date: @absent.date }
    assert_redirected_to absent_path(assigns(:absent))
  end

  test "should destroy absent" do
    assert_difference('Absent.count', -1) do
      delete :destroy, id: @absent
    end

    assert_redirected_to absents_path
  end
end
