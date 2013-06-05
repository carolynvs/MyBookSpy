class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :amazon_user_id
      t.string :email

      t.timestamps
    end
  end
end
