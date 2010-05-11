class Login < ActiveRecord::Base
  validates_uniqueness_of :user_name
  validates_presence_of :user_name, :password
end
