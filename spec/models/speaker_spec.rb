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

require 'spec_helper'

describe Speaker do
    before {@speaker = FactoryGirl.create(:speaker)}
    subject {@speaker}

    it {should respond_to(:name, :biography, :blog_url, :email_address, :twitter)}
    it {should be_valid}

end
