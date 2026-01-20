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

    # Check that statuses exist (they may have sequence numbers)
    assert status_labels.any? { |label| label.start_with?("In") }
    assert status_labels.any? { |label| label.start_with?("Out") }
    assert status_labels.any? { |label| label.start_with?("Lunch") }
  end

  test "should include status color codes and icons" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    in_status = json_response["statuses"].find { |s| s["label"].start_with?("In") }

    assert_equal "#2ecc71", in_status["color_code"]
    assert_equal "✓", in_status["icon"]
  end

  test "should include all departments" do
    get api_v1_config_path, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    dept_names = json_response["departments"].map { |d| d["name"] }

    # Check that departments exist (they may have sequence numbers)
    assert dept_names.any? { |name| name.start_with?("Engineering") }
    assert dept_names.any? { |name| name.start_with?("Sales") }
  end
end
