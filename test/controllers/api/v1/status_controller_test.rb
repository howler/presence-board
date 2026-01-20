require "test_helper"

class Api::V1::StatusControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @admin = create(:user, :admin)
    @status = create(:status, :out)
  end

  test "should update status for authenticated user" do
    sign_in @user

    assert_difference "StatusLog.count", 1 do
      patch api_v1_status_path, params: { status_id: @status.id, note: "Going out" }, as: :json
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response["success"]
    assert_equal @status.id, json_response["user"]["status"]["id"]

    @user.reload
    assert_equal @status, @user.current_status
    assert_equal "Going out", @user.current_note
  end

  test "should not allow user to update another user's status" do
    sign_in @user
    other_user = create(:user, :jane)

    patch api_v1_status_path, params: {
      email: other_user.email,
      status_id: @status.id
    }, as: :json

    assert_response :unauthorized
  end

  test "should allow admin to update any user's status" do
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

  test "should require authentication or email" do
    patch api_v1_status_path, params: { status_id: @status.id }, as: :json
    assert_response :unauthorized
  end

  test "should return error for invalid status" do
    sign_in @user

    patch api_v1_status_path, params: { status_id: 99999 }, as: :json
    assert_response :not_found
  end

  test "should return error for invalid user" do
    patch api_v1_status_path, params: {
      email: "nonexistent@example.com",
      status_id: @status.id
    }, as: :json
    assert_response :not_found
  end

  test "should broadcast status update via ActionCable" do
    sign_in @user

    assert_broadcasts "presence", 1 do
      patch api_v1_status_path, params: {
        status_id: @status.id,
        note: "Test broadcast"
      }, as: :json
    end
  end
end
