class ActiveListsController < ApplicationController

  def create
    @list = ActiveList.new()
    @list.user_id = params[:user_id]
    @list.cheddar_list_id = params[:cheddar_list_id]
    @list.title = params[:title]
    if @list.user_id != current_user.id
      redirect_to lists_path(current_user)
    elsif @list.save
      redirect_to lists_path(current_user)
    else
      redirect_to lists_path(current_user)
    end
  end

  def destroy
    @list = ActiveList.find(params[:id])
    @list.destroy
    redirect_to lists_path(current_user)
  end
end
