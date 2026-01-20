require "test_helper"

class UserAuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  test "should sign up new user" do
    get new_user_registration_path
    assert_response :success

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
    assert_equal "New User", User.last.name
  end

  test "should sign in existing user" do
    get new_user_session_path
    assert_response :success

    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "should sign out user" do
    sign_in @user
    delete destroy_user_session_path
    assert_redirected_to new_user_session_path
  end

  test "should redirect to sign in when accessing protected route" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test "should allow access to kiosk without authentication" do
    get kiosk_path
    assert_response :success
  end
end
