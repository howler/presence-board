class CreateStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :statuses do |t|
      t.string :label, null: false
      t.string :color_code, null: false
      t.string :icon

      t.timestamps
    end
  end
end
