class AddTokenToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :token, :string
    add_index :tasks, :token, unique: true
  end
end
