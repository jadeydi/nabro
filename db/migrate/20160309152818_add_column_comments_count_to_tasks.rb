class AddColumnCommentsCountToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :comments_count, :integer, default: 0
    add_column :tasks, :likes_count, :integer, default: 0
  end
end
