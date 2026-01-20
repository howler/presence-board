require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @department = create(:department, :engineering)
    @status = create(:status)
    @user = create(:user, department: @department, current_status: @status)
    @admin = create(:user, :admin)
  end

  test "should get index without authentication" do
    get api_v1_users_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.is_a?(Array)
    assert json_response.length > 0
  end

  test "should filter users by department" do
    get api_v1_users_path, params: { department_id: @department.id }, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    json_response.each do |user_data|
      assert_equal @department.name, user_data["department"]
    end
  end

  test "should search users by name" do
    get api_v1_users_path, params: { search: "John" }, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.any? { |u| u["name"].include?("John") }
  end

  test "should include user status information" do
    get api_v1_users_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    user_data = json_response.find { |u| u["id"] == @user.id }

    assert_not_nil user_data["status"]
    assert_equal @status.label, user_data["status"]["label"]
    assert_equal @status.color_code, user_data["status"]["color_code"]
  end

  test "should include department information" do
    get api_v1_users_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    user_data = json_response.find { |u| u["id"] == @user.id }

    assert_equal @department.name, user_data["department"]
  end
end
