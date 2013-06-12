class CreateAuthorAlertHistories < ActiveRecord::Migration
  def change
    create_table :author_alert_histories do |t|
      t.integer :author_alert_id
      t.integer :book_id

      t.timestamps
    end
  end
end
