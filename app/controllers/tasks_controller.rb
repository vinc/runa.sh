class TasksController < ApplicationController
  def index
    @tasks = Task.order(updated_at: :desc)
  end

  def show
    @task = Task.find(params["id"])
  end

  def edit
    @task = Task.find(params["id"])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      redirect :back
    end
  end

  def update
    @task = Task.find(params["id"])
    if @task.update(task_params)
      redirect_to @task
    else
      redirect :back
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :input)
  end
end
