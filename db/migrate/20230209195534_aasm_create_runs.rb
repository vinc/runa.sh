class AasmCreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table(:runs) do |t|
      t.string :state
      t.timestamps null: false 
    end
  end
end
