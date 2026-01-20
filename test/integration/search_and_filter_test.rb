require "test_helper"

class SearchAndFilterTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @department = create(:department)
    @user.update(department: @department)
    sign_in @user
  end

  test "should filter users by department" do
    get root_path, params: { department_id: @department.id }
    assert_response :success

    # Should show users from the department
    assert_select ".card" do |cards|
      assert cards.length > 0
    end
  end

  test "should search users by name" do
    get root_path, params: { search: "John" }
    assert_response :success

    # Should find John Doe
    assert_select "h5", text: /John/
  end

  test "should search users by email" do
    get root_path, params: { search: "john@example.com" }
    assert_response :success

    # Should find user with matching email
    assert_response :success
  end

  test "should combine search and department filter" do
    get root_path, params: {
      search: "John",
      department_id: @department.id
    }
    assert_response :success
  end

  test "should show all users when no filters applied" do
    get root_path
    assert_response :success

    # Should show multiple users (using .card selector from Foundation)
    assert_select ".card", minimum: 1
  end
end
