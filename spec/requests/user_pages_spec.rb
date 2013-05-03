require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Index page" do
    let(:user) {FactoryGirl.create(:attendee)}

    before(:each) do
      sign_in user
      visit users_path
    end

    it {should have_selector('title', text: app_title('All Users'))}

    describe "pagination" do
        before(:all) {30.times {FactoryGirl.create(:user)}}
        after(:all) {User.delete_all}

        it {should have_selector 'div.pagination'}
        it "should list each user" do
            User.paginate(page: 1).each do |user|
            page.should have_selector('li', text: user.name)
          end
        end
    end
  end

  #Sign up
  describe "signup page" do
    before { visit signup_path}
    let(:submit) {"Create an account"}

    it "should have header sign-up" do
      should have_selector("h1", text: "Sign-up")
      should have_selector("title", text: "CodeMesher:  Mesh your CodeMash Experience | Sign-up")
    end

    #Failure
    describe "invalid information for new user" do
      it "should not create a new user" do
        expect { click_button submit }.not_to change(User, :count).by(1)
      end

      describe "after submission" do
        before {click_button submit }
        it { should have_content('error')}
      end

      #password validations only valid on create
      describe "password errors should exist" do
        before {click_button submit}
        it { should have_selector('li', text: "Password can't be blank")}
        it { should have_selector('li', text: "Password is too short (minimum is 6 characters)")}
        it { should have_selector('li', text: "Password confirmation can't be blank")}
      end
    end

    #Valid
    describe "with valid user information" do
      before do
        fill_in "Name", with: "Mac Leman"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "hippo1"
        fill_in "Confirm", with: "hippo1"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) {User.find_by_email("user@example.com")}

        it { should have_link('sign-out', href: signout_path) }

      end
    end

    describe "profile page" do
      let(:user) {FactoryGirl.create(:user)}
      before { visit user_path(user) }

      it { should have_selector("title", text: "#{user.name} Profile")}
      it { should have_selector("h1", text: user.name)}
    end
  end

  #Edit
  describe "Edit" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "pages" do
      it {should have_selector("h3", text: "Update your profile")}
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end

    it "email field should not be editable"
    it "test to test editable fields"

    describe "with valid information" do
      let(:new_name) {"Fred Rogers"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: user.email.downcase
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password_confirmation
        click_button "Save Changes"
      end

      it { should have_selector("title", content: app_title('Edit User'))}
      it { should have_selector('div.alert.alert-success')}
      it { should have_link('sign-out', href: signout_path)}
      specify { user.reload.name == new_name}
    end
  end
end
