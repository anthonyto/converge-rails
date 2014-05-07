collection @event
attributes :id, :name, :location, :start_time, :end_time, :description, :created_at, :uid

child :pictures do 
	node :url do |i| 
		i.image(:medium)
	end
end