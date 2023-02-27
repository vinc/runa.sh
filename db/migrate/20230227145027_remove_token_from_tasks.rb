class RemoveTokenFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :token
  end
end
