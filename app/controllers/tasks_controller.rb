class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.order(updated_at: :desc)
  end

  def show
    @task = Task.find_by(uuid: params["uuid"])
  end

  def edit
    @task = Task.find_by(uuid: params["uuid"])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find_by(uuid: params["uuid"])
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :input, :assets)
  end
end
