class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :access_token
      t.string :avatar_url
      t.string :gender
      t.datetime :last_clicked_at
      t.string :nickname
      t.string :openId
      t.string :profile_url
      t.string :provider
      t.string :refresh_token

      t.timestamps null: false
    end
  end
end
