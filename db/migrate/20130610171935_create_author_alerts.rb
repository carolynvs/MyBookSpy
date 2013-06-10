class CreateAuthorAlerts < ActiveRecord::Migration
  def change
    create_table :author_alerts do |t|
      t.integer :user_id
      t.integer :author_id

      t.timestamps
    end
  end
end
