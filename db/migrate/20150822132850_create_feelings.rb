class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.datetime :ended_at
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :feelings, :user_id
  end
end
