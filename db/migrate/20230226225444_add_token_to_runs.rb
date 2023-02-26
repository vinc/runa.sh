class AddTokenToRuns < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :token, :string
    add_index :runs, :token, unique: true
  end
end
