class AddColumnsBodyAndQualityToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :body, :text
    add_column :tasks, :quality, :integer, default: 1
  end
end
