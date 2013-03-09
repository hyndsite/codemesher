# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe UserRole do
    before do
        @user_role  = UserRole.new
        @user_role.role = Role.find_by_name(:attendee)
        @user_role.user = FactoryGirl.create(:user)
    end

    subject { @user_role }

    it "should respond to"  do
        should respond_to(:role)
        should respond_to(:user)
    end

    describe "with proper associations" do
        before {@user_role.save}

        it {should be_valid}
    end


    # describe "with no associated role" do
    #     before do
    #         @user_role.role = nil
    #         @user_role.save
    #     end

    #     it {should_not be_valid }
    # end

    # describe "with no associated user " do
    #     before do
    #         @user_role.user = nil
    #         @user_role.save
    #     end

    #     it { should_not be_valid}
    # end

end
