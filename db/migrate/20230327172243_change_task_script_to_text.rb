class ChangeTaskScriptToText < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :script, :text
  end
end
