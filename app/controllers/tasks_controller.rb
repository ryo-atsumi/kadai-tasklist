class TasksController < ApplicationController
  before_action :require_user_logged_in 
  before_action :correct_user ,only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks
  end

  def show
    @tasks = Task.find(params[:id])
  end

  def new
    @tasks = Task.new
  end

  def create
    @tasks = Task.new(task_params)
    
    if @tasks.save
      flash[:success] = 'タスクの作成に成功しました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end

  def edit
    @tasks = Task.find(params[:id])
  end

  def update
    @tasks = Task.find(params[:id])

    if @tasks.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:content, :status ,:user_id)
  end
  
  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end
end