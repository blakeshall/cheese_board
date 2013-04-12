FactoryGirl.define do
  factory :user do
    cheddar_id 123
    cheddar_username "johnsmith"
    cheddar_url "https://api.cheddarapp.com/v1/users/123"
    cheddar_token "somekindastring"
  end
end