require 'spec_helper'

describe UsersController do

  before(:each) do
    lists = File.new(fixture_path + '/' + 'lists.json')
    stub_request(:get, "https://api.cheddarapp.com/v1/lists").
         with(:headers => {'Authorization'=>'Bearer somekindastring'}).
         to_return(:status => 200, :body => lists, :headers => {'Content-Type' => 'application/json'})

    tasks = File.new(fixture_path + '/' + 'tasks.json')
    stub_request(:get, "https://api.cheddarapp.com/v1/lists/12344/tasks").
         with(:headers => {'Authorization'=>'Bearer somekindastring'}).
         to_return(:status => 200, :body => tasks, :headers => {'Content-Type' => 'application/json'})
  end

  describe "GET lists" do
    it "assigns @user" do
      user = FactoryGirl.create(:user)
      get :lists, id: user.id
      assigns(:user).should eq(user)
    end

    it "assigns @lists" do
      user = FactoryGirl.create(:user)
      lists = user.get_lists
      get :lists, id: user.id
      assigns(:lists).should eq(lists)
    end

    it "assigns @active" do
      active_list = FactoryGirl.create(:active_list)
      user = active_list.user
      get :lists, id: user.id
      assigns(:active).should eq([active_list])
    end
  end

  describe "GET list" do
    it "assigns @user" do
      active_list = FactoryGirl.create(:active_list)
      user = active_list.user
      get :list, id: user.id, list_id: active_list.cheddar_list_id
      assigns(:user).should eq(user)
    end

    it "assigns @list" do
      active_list = FactoryGirl.create(:active_list)
      user = active_list.user
      get :list, id: user.id, list_id: active_list.cheddar_list_id
      assigns(:list).should eq(active_list)
    end

    it "assigns @tasks" do
      active_list = FactoryGirl.create(:active_list)
      user = active_list.user
      tasks = user.get_tasks(active_list.cheddar_list_id)
      get :list, id: user.id, list_id: active_list.cheddar_list_id
      assigns(:tasks).should eq(tasks)
    end
  end
end