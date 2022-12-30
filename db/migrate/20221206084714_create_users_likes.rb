class CreateUsersLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :users_likes do |t|
      t.references :user1, null: false, index: true
      t.references :user2, null: false, index: true
      t.timestamps

    end
  end
end
