class UsersController < ApplicationController
  def lists
    @user = User.find(params[:id])
    @lists = @user.get_lists
  end

  def list
    @user = User.find(params[:id])
    @tasks = @user.get_tasks(params[:list_id])
    render layout: false
  end
end
