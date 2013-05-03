# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :memberships
  has_many :users, through: :memberships

  GROUP_NAME_REGEX = /^\A[\w+\-.]+[\w\s\-\_\+\.]+$/i
  validates :name, presence: true,
                length: {in: 3..25},
                format: {with: GROUP_NAME_REGEX},
                uniqueness: {case_sensitive: false}


end
