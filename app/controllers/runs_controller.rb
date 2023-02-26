class RunsController < ApplicationController
  def index
    @runs = (params["task_id"] ? Task.find(params["task_id"]).runs : Run.all).order(updated_at: :desc)
  end

  def show
    @run = Run.find(params["id"])
  end

  def create
    @task = Task.find(params["task_id"])
    @run = @task.runs.create
    if @run.save
      RunJob.perform_later(@run)
      redirect_to @run
    else
      redirect_to @task
    end
  end

  def cancel
    @run = Run.find(params["id"])
    @run.cancel!
    redirect_to @run
  end
end
