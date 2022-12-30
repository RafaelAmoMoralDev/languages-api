class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :user1, null: false, index: true
      t.references :user2, null: false, index: true
      t.string :location, null: false
      t.datetime :datetime, null: false
      t.timestamps
    end
  end
end
