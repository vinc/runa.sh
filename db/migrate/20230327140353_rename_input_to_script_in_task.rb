class RenameInputToScriptInTask < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :input, :script
  end
end
