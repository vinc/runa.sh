class AddTaskToRuns < ActiveRecord::Migration[7.0]
  def change
    add_reference :runs, :task, null: false, foreign_key: true
  end
end
