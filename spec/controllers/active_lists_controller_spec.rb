require 'spec_helper'

describe ActiveListsController do
  before(:each) do
    @list = FactoryGirl.create(:active_list)
    @user = @list.user
    sign_in @user
  end

  describe "POST create" do
    it "should create a new active list" do
      list = FactoryGirl.build(:active_list, user: @user)
      expect{
        post :create, user_id: list.user_id, cheddar_list_id: list.cheddar_list_id,
          title: list.title
        }.to change(ActiveList, :count).by(1)
    end
  end

  describe "DELETE destroy" do
    it "should destroy the list" do
      expect{
        delete :destroy, id: @list.id
        }.to change(ActiveList, :count).by(-1)
    end

    it "redirects to users#lists" do
      delete :destroy, id: @list.id
      response.should redirect_to lists_url(@list.user_id)
    end
  end

end