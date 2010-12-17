require 'test_helper'

class TopicAttributesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_attributes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_attribute" do
    assert_difference('TopicAttribute.count') do
      post :create, :topic_attribute => { }
    end

    assert_redirected_to topic_attribute_path(assigns(:topic_attribute))
  end

  test "should show topic_attribute" do
    get :show, :id => topic_attributes(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => topic_attributes(:one).id
    assert_response :success
  end

  test "should update topic_attribute" do
    put :update, :id => topic_attributes(:one).id, :topic_attribute => { }
    assert_redirected_to topic_attribute_path(assigns(:topic_attribute))
  end

  test "should destroy topic_attribute" do
    assert_difference('TopicAttribute.count', -1) do
      delete :destroy, :id => topic_attributes(:one).id
    end

    assert_redirected_to topic_attributes_path
  end
end
