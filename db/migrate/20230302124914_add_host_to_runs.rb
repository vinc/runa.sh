class AddHostToRuns < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :host, :string
  end
end
