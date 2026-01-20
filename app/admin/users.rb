ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :department_id, :avatar_url, :role, :current_status_id, :current_note

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :department
    column :current_status
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :department
  filter :current_status
  filter :role
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :department
      f.input :avatar_url
      f.input :role, as: :select, collection: [["User", "user"], ["Admin", "admin"]]
      f.input :current_status
      f.input :current_note
    end
    f.actions
  end
end
