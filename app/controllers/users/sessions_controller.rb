class Users::SessionsController < Devise::SessionsController
  # Override the default redirect after sign in
  def after_sign_in_path_for(resource)
    root_path
  end

  # Override the default redirect after sign out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
