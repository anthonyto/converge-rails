class Event < ActiveRecord::Base
  has_many :pictures
  accepts_nested_attributes_for :pictures
  
  has_attached_file :event_picture, :default_url => "/images/:id/missing.png"
  validates_attachment_content_type :event_picture, :content_type => /\Aimage\/.*\Z/
  
end
