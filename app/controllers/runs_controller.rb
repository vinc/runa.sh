class RunsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
  before_action :set_breadcrumb

  def index
    scope = (@task || current_user).runs
    scope = scope.where("output ~* ?", params["query"]) if params["query"].present?
    scope = scope.order(created_at: :desc).page(params["page"]).per(params["limit"] || 24)
    @runs = authorize scope
    @breadcrumb += [["Runs"]]
  end

  def show
    @run = authorize @task.runs.find_by(sequential_id: params["sequential_id"])
    @breadcrumb += [["Runs", task_runs_path(@task)], [@run.sequential_id]]
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

  protected

  def set_task
    @task = current_user.tasks.find_by(uuid: params["task_uuid"])
  end

  def set_breadcrumb
    @breadcrumb = [["Runa", root_path]]
    @breadcrumb += [["Tasks", tasks_path], [@task.uuid, @task]] if @task
  end
end
