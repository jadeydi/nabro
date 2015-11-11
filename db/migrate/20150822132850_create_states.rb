class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.datetime :ended_at
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :states, :user_id
  end
end
