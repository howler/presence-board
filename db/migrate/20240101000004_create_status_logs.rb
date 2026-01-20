class CreateStatusLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :status_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
