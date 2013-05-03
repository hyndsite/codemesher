# == Schema Information
#
# Table name: speakers
#
#  id            :integer          not null, primary key
#  biography     :text
#  blog_url      :string(255)
#  email_address :string(255)
#  name          :string(255)
#  twitter       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Speaker < ActiveRecord::Base
  attr_accessible :biography, :blog_url, :email_address, :name, :twitter
end
