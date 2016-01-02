class CreateUserAttempts < ActiveRecord::Migration
  def change
    create_table :user_attempts do |t|
      t.integer :user_id
      t.integer :attempt_id
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
