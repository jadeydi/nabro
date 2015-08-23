class CreateUserAuths < ActiveRecord::Migration
  def change
    create_table :user_auths do |t|
      t.string :provider
      t.string :open_id
      t.text :original

      t.timestamps null: false
    end

    add_index :user_auths, [:provider, :open_id], unique: true
  end
end
