class RemoveTokenFromRuns < ActiveRecord::Migration[7.0]
  def change
    remove_column :runs, :token
  end
end
