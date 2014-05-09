class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :file_name
      t.datetime :time_taken
      t.integer :event_id

      t.timestamps
    end
  end
end
