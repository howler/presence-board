require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @department = create(:department)
    @status = create(:status)
    @user = create(:user, department: @department, current_status: @status)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should require name" do
    @user.name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "should require email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should have unique email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "should have default role of user" do
    new_user = build(:user)
    new_user.save!
    assert_equal "user", new_user.role
  end

  test "admin? should return true for admin users" do
    admin_user = create(:user, :admin)
    assert admin_user.admin?
  end

  test "admin? should return false for regular users" do
    assert_not @user.admin?
  end

  test "update_status! should update current status and create log" do
    new_status = create(:status, :out)
    note = "Going out for lunch"

    assert_difference "StatusLog.count", 1 do
      @user.update_status!(new_status, note: note)
    end

    assert_equal new_status, @user.reload.current_status
    assert_equal note, @user.current_note

    log = @user.status_logs.last
    assert_equal new_status, log.status
    assert_equal note, log.note
  end

  test "should belong to department" do
    assert_respond_to @user, :department
  end

  test "should belong to current status" do
    assert_respond_to @user, :current_status
  end

  test "should have many status logs" do
    assert_respond_to @user, :status_logs
  end
end
