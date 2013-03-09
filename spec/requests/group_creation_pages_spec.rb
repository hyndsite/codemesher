require 'spec_helper'

describe "GroupCreationPages" do
    subject {page}

    let(:user) {FactoryGirl.create(:attendee)}

    before(:each) do
      sign_in user
      visit new_group_path
    end

    describe "Create Page" do
        it "should have header Create Group" do
            should have_selecter(:title, app_title("Create New Group"))
        end
    end

end
