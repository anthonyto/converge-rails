class RemoveFileNameFromPicture < ActiveRecord::Migration
  def change
    remove_column :pictures, :file_name, :string
  end
end
