class UsersController < ApplicationController
  def lists
    @user = User.find(params[:id])
    @lists = @user.get_lists
    @active = @user.active_lists
  end

  def list
    @user = User.find(params[:id])
    @list = ActiveList.where(user_id: @user.id, cheddar_list_id: params[:list_id]).first || not_found
    @tasks = @user.get_tasks(params[:list_id])
    render layout: false
  end
end
