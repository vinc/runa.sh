class AddStateTimestampsToRun < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :started_at, :timestamp
    add_column :runs, :finished_at, :timestamp
    add_column :runs, :canceled_at, :timestamp
  end
end
