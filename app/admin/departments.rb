ActiveAdmin.register Department do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :users_count do |dept|
      dept.users.count
    end
    column :created_at
    actions
  end

  filter :name
  filter :created_at
end
