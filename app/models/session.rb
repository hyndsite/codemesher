class Session < ActiveRecord::Base
  belongs_to :speaker
  attr_accessible :abstract, :finish, :level, :room, :start, :title, :track
end
