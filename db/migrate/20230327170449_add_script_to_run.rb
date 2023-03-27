class AddScriptToRun < ActiveRecord::Migration[7.0]
  def change
    add_column :runs, :script, :text

    Run.find_each do |run|
      run.update(script: run.task.script)
    end
  end
end
