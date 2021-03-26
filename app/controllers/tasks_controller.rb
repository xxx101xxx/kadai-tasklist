class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
 
  
  def index
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
      @task = Task.find(params[:id])
       
  end

  def new
      @task = Task.new
  end

  def create
      @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
       @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
      
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task が正常に処理されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が処理されませんでした'
      render :edit
    end
  end

  def destroy
      
    @task.destroy
    flash[:success] = 'Taskを削除しました。'
    redirect_to tasks_url

  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  

end  
