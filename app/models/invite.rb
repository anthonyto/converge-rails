class Invite < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, foreign_key: 'uid'  
end
