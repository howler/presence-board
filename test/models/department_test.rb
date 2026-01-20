require "test_helper"

class DepartmentTest < ActiveSupport::TestCase
  def setup
    @department = create(:department)
  end

  test "should be valid" do
    assert @department.valid?
  end

  test "should require name" do
    @department.name = nil
    assert_not @department.valid?
    assert_includes @department.errors[:name], "can't be blank"
  end

  test "should have unique name" do
    duplicate_dept = @department.dup
    assert_not duplicate_dept.valid?
    assert_includes duplicate_dept.errors[:name], "has already been taken"
  end

  test "should have many users" do
    assert_respond_to @department, :users
  end
end
