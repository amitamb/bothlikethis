require 'test_helper'

class SessionUsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:session_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session_user" do
    assert_difference('SessionUser.count') do
      post :create, :session_user => { }
    end

    assert_redirected_to session_user_path(assigns(:session_user))
  end

  test "should show session_user" do
    get :show, :id => session_users(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => session_users(:one).id
    assert_response :success
  end

  test "should update session_user" do
    put :update, :id => session_users(:one).id, :session_user => { }
    assert_redirected_to session_user_path(assigns(:session_user))
  end

  test "should destroy session_user" do
    assert_difference('SessionUser.count', -1) do
      delete :destroy, :id => session_users(:one).id
    end

    assert_redirected_to session_users_path
  end
end
