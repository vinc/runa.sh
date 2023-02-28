class AddUserRefToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user, null: false, default: 1, foreign_key: true
  end
end
