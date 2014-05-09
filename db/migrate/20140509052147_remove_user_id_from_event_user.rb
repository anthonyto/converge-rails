class RemoveUserIdFromEventUser < ActiveRecord::Migration
  def change
    remove_column :events_users, :user_id, :integer
  end
end
