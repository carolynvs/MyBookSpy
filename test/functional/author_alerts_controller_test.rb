require 'test_helper'

class AuthorAlertsControllerTest < ActionController::TestCase
  setup do
    @author_alert = author_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:author_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author_alert" do
    assert_difference('AuthorAlert.count') do
      post :create, author_alert: { author_id: @author_alert.author_id, user_id: @author_alert.user_id }
    end

    assert_redirected_to author_alert_path(assigns(:author_alert))
  end

  test "should show author_alert" do
    get :show, id: @author_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @author_alert
    assert_response :success
  end

  test "should update author_alert" do
    put :update, id: @author_alert, author_alert: { author_id: @author_alert.author_id, user_id: @author_alert.user_id }
    assert_redirected_to author_alert_path(assigns(:author_alert))
  end

  test "should destroy author_alert" do
    assert_difference('AuthorAlert.count', -1) do
      delete :destroy, id: @author_alert
    end

    assert_redirected_to author_alerts_path
  end
end
