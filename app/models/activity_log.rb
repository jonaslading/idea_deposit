class ActivityLog < ActiveRecord::Base
  attr_accessible :activity, :ip_address, :user
  
end
