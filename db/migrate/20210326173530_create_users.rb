class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.integer :phone
      t.string :description, null: false
      t.string :image, null: false
      t.integer :likes
      t.string :password_digest
      t.timestamps
    end
  end
end
