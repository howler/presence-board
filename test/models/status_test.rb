require "test_helper"

class StatusTest < ActiveSupport::TestCase
  def setup
    @status = create(:status)
  end

  test "should be valid" do
    assert @status.valid?
  end

  test "should require label" do
    @status.label = nil
    assert_not @status.valid?
    assert_includes @status.errors[:label], "can't be blank"
  end

  test "should require color_code" do
    @status.color_code = nil
    assert_not @status.valid?
    assert_includes @status.errors[:color_code], "can't be blank"
  end

  test "should have unique label" do
    duplicate_status = @status.dup
    assert_not duplicate_status.valid?
    assert_includes duplicate_status.errors[:label], "has already been taken"
  end

  test "should have many status logs" do
    assert_respond_to @status, :status_logs
  end

  test "should have many users" do
    assert_respond_to @status, :users
  end
end
