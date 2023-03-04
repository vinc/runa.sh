class AssetsController < RunsController
  before_action :set_run
  before_action :set_assets

  def index
    @breadcrumb += [["Runs", task_runs_path(@task)], [@run.sequential_id, task_run_path(@task.uuid, @run.sequential_id)], ["Assets"]]
  end

  def show
    asset = @assets.attachments.find { |a| a.filename == params["filename"] }
    raise ActiveRecord::RecordNotFound if asset.nil?
    redirect_to(url_for(asset))
  end

  protected

  def set_run
    @run = authorize @task.runs.find_by(sequential_id: params["run_sequential_id"])
  end

  def set_assets
    @assets = @run.assets
  end
end
