require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  test "should redirect to root after sign in" do
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }

    assert_redirected_to root_path
  end

  test "should redirect to sign in after sign out" do
    sign_in @user
    delete destroy_user_session_path

    assert_redirected_to new_user_session_path
  end
end
