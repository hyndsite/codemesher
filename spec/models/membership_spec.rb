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

require 'spec_helper'

describe Membership do
  pending "add some examples to (or delete) #{__FILE__}"
end
