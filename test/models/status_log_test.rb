require "test_helper"

class StatusLogTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @status = create(:status)
    @status_log = create(:status_log, user: @user, status: @status)
  end

  test "should be valid" do
    assert @status_log.valid?
  end

  test "should require user" do
    @status_log.user = nil
    assert_not @status_log.valid?
  end

  test "should require status" do
    @status_log.status = nil
    assert_not @status_log.valid?
  end

  test "should belong to user" do
    assert_respond_to @status_log, :user
  end

  test "should belong to status" do
    assert_respond_to @status_log, :status
  end
end
