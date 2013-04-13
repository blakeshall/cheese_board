require "spec_helper"
require "ostruct"

describe User do
  before(:each) do
    # Mock auth object for oauth
    @auth = OpenStruct.new
    extra = OpenStruct.new
    raw_info = OpenStruct.new
    credentials = OpenStruct.new
    # All values from default factory
    raw_info.id = 123
    raw_info.username = 'johnsmith'
    raw_info.url = 'https://api.cheddarapp.com/v1/users/123'
    credentials.token = 'somekindasting'
    extra.raw_info = raw_info
    @auth.extra = extra
    @auth.credentials = credentials

    lists = File.new(fixture_path + '/' + 'lists.json')
    stub_request(:get, "https://api.cheddarapp.com/v1/lists").
         with(:headers => {'Authorization'=>'Bearer somekindastring'}).
         to_return(:status => 200, :body => lists, :headers => {'Content-Type' => 'application/json'})

    tasks = File.new(fixture_path + '/' + 'tasks.json')
    stub_request(:get, "https://api.cheddarapp.com/v1/lists/12344/tasks").
         with(:headers => {'Authorization'=>'Bearer somekindastring'}).
         to_return(:status => 200, :body => tasks, :headers => {'Content-Type' => 'application/json'})
  end

  it "finds an existing user for Cheddar oauth" do
    user = FactoryGirl.create(:user)
    expect(User.find_for_cheddar_oauth(@auth)).to eq(user)
  end

  it "creates a new user for Cheddar oauth" do
    new_user = User.find_for_cheddar_oauth(@auth)
    expect(new_user.cheddar_id).to eq(123)
  end

  it "gets the lists of a user" do
    user = FactoryGirl.create(:user)
    lists = user.get_lists
    expect(lists.first['title']).to eq('A List')
  end

  it "gets the tasks for a list" do
    user = FactoryGirl.create(:user)
    task = user.get_tasks(12344).first
    expect(task['text']).to eq('A task')
  end
end
