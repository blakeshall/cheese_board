require 'spec_helper'

describe PagesController do
  describe "GET index" do
    it "should render index" do
      get :index
      response.should render_template("index")
    end

    it "should get status 200" do
      get :index
      response.code.should eq("200")
    end
  end
end