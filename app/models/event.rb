class Event < ActiveRecord::Base
  belongs_to :user, foreign_key: 'uid'
  has_many :pictures, :dependent => :destroy
  
  accepts_nested_attributes_for :pictures
  
end
