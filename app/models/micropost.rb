class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id, :title
  belongs_to :user
  validates :content, :length => { :maximum => 140 }
end
