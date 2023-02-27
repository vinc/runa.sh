class AddUuidToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :uuid, :uuid
    add_index :tasks, :uuid, unique: true
  end
end
