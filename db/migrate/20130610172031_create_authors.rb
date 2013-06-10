class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.datetime :last_sync_date

      t.timestamps
    end
  end
end
