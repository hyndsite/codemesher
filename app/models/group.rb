class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true,
                length: {in: 3..25},
                uniqueness: {case_sensitive: false}
end
