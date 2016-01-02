class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
