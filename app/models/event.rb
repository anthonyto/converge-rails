class Event < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  belongs_to :user, foreign_key: 'uid'
  accepts_nested_attributes_for :pictures
  
end
