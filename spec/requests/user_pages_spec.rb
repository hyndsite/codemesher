require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path}
    let(:submit) {"Create an account"}

    it "should have header subjectign-up" do
      should have_selector("h1", text: "Sign-up")
      should have_selector("title", text: "CodeMesher:  Mesh your CodeMash Experience | Sign-up")
    end

    describe "invalid information for new user" do
      it "should not create a new user" do
        expect { click_button submit }.not_to change(User, :count).by(1)
      end

      describe "after submission" do
        before {click_button submit }
        it { should have_content('error')}
      end
    end

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

  describe "Edit" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "pages" do
      it {should have_selector("h3", text: "Update your profile")}
      it {should have_link('change', href: 'http://gravatar.com/emails')}
      it "email field should not be editable"
    end

    describe "with invalid information" do
      before {click_button 'Save Changes'}
      it {should have_content('error')}
    end

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
