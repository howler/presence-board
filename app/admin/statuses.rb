ActiveAdmin.register Status do
  permit_params :label, :color_code, :icon

  index do
    selectable_column
    id_column
    column :label
    column :color_code do |status|
      div style: "background-color: #{status.color_code}; width: 50px; height: 20px; border: 1px solid #ccc;"
    end
    column :icon
    column :users_count do |status|
      status.users.count
    end
    column :created_at
    actions
  end

  filter :label
  filter :created_at

  form do |f|
    f.inputs "Status Details" do
      f.input :label
      f.input :color_code, as: :string, hint: "Hex color code (e.g., #00FF00)"
      f.input :icon, hint: "Icon name or emoji"
    end
    f.actions
  end
end
