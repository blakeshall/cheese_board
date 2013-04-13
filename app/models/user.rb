require 'net/http'
require 'uri'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :trackable,
         :omniauthable, :omniauth_providers => [:cheddar]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :cheddar_id, :cheddar_username, :cheddar_url, :cheddar_token
  # attr_accessible :title, :body
  has_many :active_lists

  def self.find_for_cheddar_oauth(auth, signed_in_resource=nil)
    user = User.where(:cheddar_id => auth.extra.raw_info.id).first
    unless user
      user = User.create(cheddar_username:auth.extra.raw_info.username,
                           cheddar_id:auth.extra.raw_info.id,
                           cheddar_url:auth.extra.raw_info.url,
                           cheddar_token: auth.credentials.token
                           )
    end
    user
  end

  def get_lists
    options = {headers: {'Authorization'=> "Bearer #{cheddar_token}"}}
    response = HTTParty.get('https://api.cheddarapp.com/v1/lists', options)
    lists = []
    response.parsed_response.each do |list|
      lists.push(list) if list["archived_at"].nil?
    end
    return lists
  end

  def get_tasks(list_id)
    options = {headers: {'Authorization'=> "Bearer #{cheddar_token}"}}
    response = HTTParty.get("https://api.cheddarapp.com/v1/lists/#{list_id}/tasks", options)
    tasks = []
    response.parsed_response.each do |task|
      tasks.push(task) if task["archived_at"].nil? & task["completed_at"].nil?
    end
    return tasks
  end
end
