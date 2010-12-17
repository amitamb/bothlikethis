require 'test_helper'

class SessionUserMessagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:session_user_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session_user_message" do
    assert_difference('SessionUserMessage.count') do
      post :create, :session_user_message => { }
    end

    assert_redirected_to session_user_message_path(assigns(:session_user_message))
  end

  test "should show session_user_message" do
    get :show, :id => session_user_messages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => session_user_messages(:one).to_param
    assert_response :success
  end

  test "should update session_user_message" do
    put :update, :id => session_user_messages(:one).to_param, :session_user_message => { }
    assert_redirected_to session_user_message_path(assigns(:session_user_message))
  end

  test "should destroy session_user_message" do
    assert_difference('SessionUserMessage.count', -1) do
      delete :destroy, :id => session_user_messages(:one).to_param
    end

    assert_redirected_to session_user_messages_path
  end
end
