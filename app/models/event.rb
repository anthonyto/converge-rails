class Event < ActiveRecord::Base
  has_and_belongs_to_many :user, foreign_key: 'uid'
  has_many :pictures, :dependent => :destroy
  
  accepts_nested_attributes_for :pictures
  
  
  
end
