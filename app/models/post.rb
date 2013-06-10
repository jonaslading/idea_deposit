class Post < ActiveRecord::Base
  attr_accessible :content, :title, :modified_by, :status, :progress
  
  validates :title, :content, :presence => true
  validates :title, :length => { :minimum => 2 }
  validates :title, :uniqueness => true
end
