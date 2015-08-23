class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :access_token
      t.datetime :expires_at
      t.string :refresh_token

      t.string :avatar_url
      t.string :profile_url

      t.string :location
      t.string :languages

      t.string :nickname
      t.integer :gender

      t.string :provider
      t.string :uid

      t.text :bio

      t.datetime :last_clicked_at

      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
