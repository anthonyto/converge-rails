class AddUidToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :uid, :string
  end
end
