class AddSequentialIdToRuns < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :sequential_id, :integer
    add_index :runs, :sequential_id
  end
end
