# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  group_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner       :boolean          default(FALSE), not null
#  contributor :boolean          default(FALSE), not null
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_protected :owner, :contributor
end
