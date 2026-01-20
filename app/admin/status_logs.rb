ActiveAdmin.register StatusLog do
  permit_params :user_id, :status_id, :note

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :note
    column :created_at
    actions
  end

  filter :user
  filter :status
  filter :created_at

  form do |f|
    f.inputs "Status Log Details" do
      f.input :user
      f.input :status
      f.input :note
    end
    f.actions
  end
end
