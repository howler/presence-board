require "test_helper"

class StatusUpdateFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @status = create(:status, :out)
    sign_in @user
  end

  test "complete status update flow" do
    # View dashboard
    get root_path
    assert_response :success

    # Update status via API
    assert_difference "StatusLog.count", 1 do
      patch api_v1_status_path, params: {
        status_id: @status.id,
        note: "Going out for lunch"
      }, as: :json
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response["success"]

    # Verify status was updated
    @user.reload
    assert_equal @status, @user.current_status
    assert_equal "Going out for lunch", @user.current_note

    # Verify status log was created
    log = @user.status_logs.last
    assert_equal @status, log.status
    assert_equal "Going out for lunch", log.note
  end

  test "status update should be visible in dashboard" do
    # Update status
    patch api_v1_status_path, params: {
      status_id: @status.id,
      note: "Test note"
    }, as: :json

    # View dashboard
    get root_path
    assert_response :success

    # Check that updated status is displayed
    @user.reload
    assert_select ".label" do |elements|
      assert elements.any? { |el| el.text.include?(@status.label) }
    end
  end
end
