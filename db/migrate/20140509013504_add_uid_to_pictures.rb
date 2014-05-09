class AddUidToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :uid, :string
  end
end
