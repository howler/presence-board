require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to root after sign up" do
    assert_difference "User.count", 1 do
      post user_registration_path, params: {
        user: {
          name: "New User",
          email: "newuser@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to root_path
  end

  test "should permit name parameter" do
    post user_registration_path, params: {
      user: {
        name: "Test Name",
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert_redirected_to root_path
    assert_equal "Test Name", User.last.name
  end
end
