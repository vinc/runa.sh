class RunsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task

  def index
    @runs = @task.runs.order(updated_at: :desc)
  end

  def show
    @run = @task.runs.find_by(sequential_id: params["sequential_id"])
  end

  def create
    @run = @task.runs.create
    if @run.save
      RunJob.perform_later(@run)
    redirect_to task_run_path(@task, @run.sequential_id)
    else
      redirect_to @task
    end
  end

  def cancel
    @run = @task.runs.find_by(sequential_id: params["sequential_id"])
    @run.cancel!
    redirect_to task_run_path(@task, @run.sequential_id)
  end

  private

  def set_task
    @task = Task.find_by(uuid: params["task_uuid"])
  end
end
