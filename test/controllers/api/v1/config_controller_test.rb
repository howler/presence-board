require "test_helper"

class Api::V1::ConfigControllerTest < ActionDispatch::IntegrationTest
  def setup
    create(:status)
    create(:status, :out)
    create(:status, :lunch)
    create(:department)
    create(:department, :sales)
  end

  test "should get config without authentication" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert json_response.key?("statuses")
    assert json_response.key?("departments")

    assert json_response["statuses"].is_a?(Array)
    assert json_response["departments"].is_a?(Array)
  end

  test "should include all statuses" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    status_labels = json_response["statuses"].map { |s| s["label"] }

    assert_includes status_labels, "In"
    assert_includes status_labels, "Out"
    assert_includes status_labels, "Lunch"
  end

  test "should include status color codes and icons" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    in_status = json_response["statuses"].find { |s| s["label"] == "In" }

    assert_equal "#2ecc71", in_status["color_code"]
    assert_equal "✓", in_status["icon"]
  end

  test "should include all departments" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    dept_names = json_response["departments"].map { |d| d["name"] }

    assert_includes dept_names, "Engineering"
    assert_includes dept_names, "Sales"
  end
end
