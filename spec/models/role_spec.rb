# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Role do
    before { @role = FactoryGirl.create(:new_role)}
    subject { @role }
    it "should repond to" do
        should respond_to(:name)
    end

    describe "should downcase role name" do
        before do
            @role = Role.new(name: "UPPER_CASE")
            @role.save
        end

        it {@role.name.should_not eq(@role.name.upcase)}
    end

    describe "should be unique" do
        let(:role_with_same_name) {role_with_same_name = @role.dup}
        before do
           role_with_same_name.save
        end

        it  "duplicate?" do
            role_with_same_name.should_not be_valid
        end
    end
end
