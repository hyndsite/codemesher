require 'spec_helper'

describe "GroupPages" do
    subject {page}

    let(:user) {FactoryGirl.create(:attendee)}
    before(:each) do
      sign_in user
    end

    #Group#Create
    describe "Create Page" do
        let(:submit) {"Create Group"}

        before {visit new_group_path}
        it "should have title" do
            should have_selector('title', text: app_title("Create New Group"))
        end

        describe "with invalid information" do
          describe "should show errors" do
            before  { click_button submit }

             it { should have_content('error')}
            end
        end

        describe "with valid information" do
            describe "should create group and redirect to group page" do
                let(:group_name) {"My Cool"}
                before do
                    fill_in "Name", with: group_name
                    click_button submit
                end

                specify {page.should have_selector('title', text: app_title("#{group_name} Group"))}

                it "should add the user as the owner" do
                    group = Group.find_by_name(group_name)
                    group.memberships.first.user.should eq(user)
                end
            end
        end
    end

    #Group#show
    describe "Show Page" do
        describe "should have specific content" do
            let(:group) {FactoryGirl.create(:group)}

            before do
                group.memberships.new(user: user)
                group.memberships.first.owner = true
                group.memberships.first.contributor = true
                group.save
                visit group_path group
            end

            subject {page}

            it { should have_selector('h3', text: group.name)}
        end
        it "should show members or message"
        it "should show option to invite members"
    end

    #Group#index
    describe "Index Page" do
        let(:group) {FactoryGirl.create(:group)}
        before do
            @user = FactoryGirl.create :attendee, :with_admin_group
            visit groups_path
        end

        it {should have_selector('title', title: app_title("Your Groups"))}

        describe "shows all associated groups" do
            it "with group names"
               # @user.groups.each do |g|
               #      should have_selector('h3', text: "#{g.name}")
               # end



        it "for groups"
            it "should have group names"
            it "group names should be hyperlinks"
            it "show current user's membership status"
            it "have administrative link for any groups current user is admin for"

        end

        it "for members"
            it "should have list of users not including current users"
            it "users should be a hyperlink"
            it "should show members current location"
            it "have admin links for members of group which current user is administrator"
            it "should status of pending invitation acceptance"
    end
end

