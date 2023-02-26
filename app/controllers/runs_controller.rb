class RunsController < ApplicationController
  def index
    @runs = (params["task_token"] ? Task.find_by(token: params["task_token"]).runs : Run.all).order(updated_at: :desc)
  end

  def show
    @run = Run.find_by(token: params["token"])
  end

  def create
    @task = Task.find_by(token: params["task_token"])
    @run = @task.runs.create
    if @run.save
      RunJob.perform_later(@run)
      redirect_to @run
    else
      redirect_to @task
    end
  end

  def cancel
    @run = Run.find_by(token: params["token"])
    @run.cancel!
    redirect_to @run
  end
end
