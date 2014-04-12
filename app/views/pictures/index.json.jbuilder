json.array!(@pictures) do |picture|
  json.extract! picture, :id, :file_name, :time_taken, :event_id, :user_id
  json.url picture_url(picture, format: :json)
end
