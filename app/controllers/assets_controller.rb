class AssetsController < RunsController
  before_action :set_run
  before_action :set_assets

  def index
  end

  def show
    filename = [params["filename"], params["format"]].compact.join(".")
    asset = @assets.attachments.find { |a| a.filename == filename }
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
