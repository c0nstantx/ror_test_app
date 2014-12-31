# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  title      :string(255)
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id, :title
  belongs_to :user
  validates :content, :length => { :maximum => 140 }
end
