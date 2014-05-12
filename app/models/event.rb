class Event < ActiveRecord::Base
  # has_and_belongs_to_many :users, association_foreign_key: "uid"
  has_many :invites
  has_many :users, through: :invites
  has_many :pictures, :dependent => :destroy
  
  accepts_nested_attributes_for :pictures
  
end
