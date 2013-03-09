# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  before_save { |role| role.name = role.name.downcase }
  attr_accessible :name
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, uniqueness: {case_sensitive: false}
end
