class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.datetime :ended_at
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
