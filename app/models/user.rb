class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:cheddar]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :cheddar_id, :cheddar_username, :cheddar_url, :cheddar_token
  # attr_accessible :title, :body

  def email
    "Stub"
  end

  def email_changed?
    false
  end

  def password
    "stubstub"
  end

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
end
