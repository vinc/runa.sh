class RenameCommandToInputInTask < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :command, :input
  end
end
