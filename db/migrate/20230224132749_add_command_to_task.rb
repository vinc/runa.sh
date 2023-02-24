class AddCommandToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :command, :string
  end
end
