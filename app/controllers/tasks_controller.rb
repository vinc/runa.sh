class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb

  def index
    scope = current_user.tasks
    scope = scope.where("name ~* ?", params["query"]) if params["query"].present?
    scope = scope.order(created_at: :desc).page(params["page"]).per(params["limit"] || 24)
    @tasks = authorize scope
    @breadcrumb += [["Tasks"]]
  end

  def show
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
    @breadcrumb += [["Tasks", tasks_path], [@task.uuid]]
  end

  def edit
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
    @breadcrumb += [["Tasks", tasks_path], [@task.uuid, @task], ["Edit"]]
  end

  def new
    @task = authorize current_user.tasks.new
    @breadcrumb += [["Tasks", tasks_path], ["New"]]
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

  def destroy
    @task = authorize current_user.tasks.find_by(uuid: params["uuid"])
    @task.destroy
    redirect_to tasks_path, notice: "The task was successfully destroyed"
  end

  protected

  def task_params
    params.require(:task).permit(:name, :script, :assets, :runner)
  end

  def set_breadcrumb
    @breadcrumb = [["Runa", root_path]]
  end
end
