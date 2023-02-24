class RunsController < ApplicationController
  before_action :set_runs, only: [:index, :create]

  def index
  end

  def show
    @run = Run.find(params["id"])
  end

  def create
    @run = @runs.create
    if @run.save
      RunJob.perform_later(@run)
      redirect_to @run
    else
      redirect :back
    end
  end

  private

  def set_runs
    @runs = params["task_id"] ? Task.find(params["task_id"]).runs : Run.all
  end
end
