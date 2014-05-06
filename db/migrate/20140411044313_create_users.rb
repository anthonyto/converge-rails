class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, {:id => false} do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (uid);"
  end
end
