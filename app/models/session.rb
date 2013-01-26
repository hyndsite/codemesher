class Session < ActiveRecord::Base
  attr_accessible :abstract, :difficulty, :end, :event_type, :id, :room, :session_lookup_id, :speaker_name, :speaker_uri, :start, :technology, :title, :uri
end
