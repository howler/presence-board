require "test_helper"

class AdminAccessTest < ActionDispatch::IntegrationTest
  def setup
    @admin = create(:user, :admin)
    @user = create(:user)
  end

  test "admin should access Active Admin" do
    sign_in @admin
    get admin_root_path
    assert_response :success
  end

  test "regular user should not access Active Admin" do
    sign_in @user
    get admin_root_path
    # Active Admin should redirect or show unauthorized
    assert_response :redirect
  end

  test "admin should update any user's status" do
    sign_in @admin
    other_user = create(:user, :jane)
    meeting_status = create(:status, :meeting)

    patch api_v1_status_path, params: {
      email: other_user.email,
      status_id: meeting_status.id,
      note: "Admin update"
    }, as: :json

    assert_response :success
    other_user.reload
    assert_equal meeting_status, other_user.current_status
  end

  test "admin should see admin link in navigation" do
    sign_in @admin
    get root_path
    assert_response :success
    assert_select "a[href=?]", admin_root_path
  end

  test "regular user should not see admin link" do
    sign_in @user
    get root_path
    assert_response :success
    assert_select "a[href=?]", admin_root_path, count: 0
  end
end
