class RenameTablesAttemptsRelations < ActiveRecord::Migration
  def change
    rename_table :attempts, :tasks
    rename_table :user_attempts, :attempts
    rename_column :attempts, :attempt_id, :task_id
  end
end
