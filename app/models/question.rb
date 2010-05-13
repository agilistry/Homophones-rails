class Question < ActiveRecord::Base
  validates_presence_of :response_size, :responses, :ask
end
