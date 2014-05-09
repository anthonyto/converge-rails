class CreateJoinTableEventUser < ActiveRecord::Migration
  def change
    create_join_table :events, :users, id: false do |t|
      t.integer :event_id
      t.string :uid
      # t.index [:event_id, :user_id]
      # t.index [:user_id, :event_id]
    end
  end
end
