class RunsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task

  def index
    @runs = authorize @task.runs.order(created_at: :desc).page(params["page"]).per(params["limit"] || 24)
  end

  def show
    @run = authorize @task.runs.find_by(sequential_id: params["sequential_id"])
  end

  def create
    @run = authorize @task.runs.new
    if @run.save
      RunJob.set(wait: 1.seconds).perform_later(@run)
    redirect_to task_run_path(@task, @run.sequential_id)
    else
      redirect_to @task
    end
  end

  def cancel
    @run = authorize @task.runs.find_by(sequential_id: params["sequential_id"])
    @run.cancel!
    redirect_to task_run_path(@task, @run.sequential_id)
  end

  private

  def set_task
    @task = current_user.tasks.find_by(uuid: params["task_uuid"])
  end
end
