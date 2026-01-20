require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  def setup
    @department = create(:department)
    @status = create(:status)
    @user = create(:user, department: @department, current_status: @status)
    @admin = create(:user, :admin, department: @department, current_status: @status)
  end

  test "should get index when authenticated" do
    sign_in @user
    get root_path
    assert_response :success
    assert_select "h1", "Presence Board"
  end

  test "should redirect to sign in when not authenticated" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test "should get kiosk without authentication" do
    get kiosk_path
    assert_response :success
  end

  test "should filter users by department" do
    sign_in @user
    get root_path, params: { department_id: @department.id }
    assert_response :success
  end

  test "should search users by name" do
    sign_in @user
    get root_path, params: { search: "John" }
    assert_response :success
  end

  test "should show update status form for authenticated users" do
    sign_in @user
    get root_path
    assert_response :success
    assert_select "form[action=?]", api_v1_status_path
  end

  test "should not show update form for unauthenticated users" do
    get kiosk_path
    assert_response :success
    assert_select "form[action=?]", api_v1_status_path, count: 0
  end
end
