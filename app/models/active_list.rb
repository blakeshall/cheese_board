class ActiveList < ActiveRecord::Base
  attr_accessible :cheddar_list_id, :user_id, :title
  belongs_to :user
end
