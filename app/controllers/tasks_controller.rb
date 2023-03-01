class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    scope = current_user.tasks
    scope = scope.where("name ILIKE ?", params["query"]) if params["query"].present?
    scope = scope.order(created_at: :desc).page(params["page"]).per(params["limit"] || 24)
    @tasks = authorize scope
  end

  def show
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
  end

  def edit
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
  end

  def new
    @task = authorize current_user.tasks.new
  end

  def create
    @task = authorize current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :input, :assets, :runner)
  end
end
