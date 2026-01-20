class AddCurrentStatusToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :current_status, null: true, foreign_key: { to_table: :statuses }
    add_column :users, :current_note, :text
  end
end
