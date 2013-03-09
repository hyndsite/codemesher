class Membership < ActiveRecord::Base
  belongs_to :user
  attr_accessible :group
end
