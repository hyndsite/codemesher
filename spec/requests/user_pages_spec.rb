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

    describe "valid new user info submitted" do
      before do
        fill_in "Name", with: "Mac Leman"
        fill_in "Email", with: "sample@example.com"
        fill_in "Password", with: "hippo1"
        fill_in "Confirm", with: "hippo1"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe "profile page" do
      let(:user) {FactoryGirl.create(:user)}
      before { visit user_path(user) }

      it { should have_selector("title", text: "#{user.name} Profile")}
      it { should have_selector("h1", text: user.name)}
    end
  end
end
