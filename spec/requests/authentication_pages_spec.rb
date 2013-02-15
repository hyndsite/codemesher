require 'spec_helper'

describe "Authentication_Pages: " do

  subject { page }
  let(:pre_title) { 'CodeMesher:  Mesh your CodeMash Experience |'}

  describe "signin page" do
    before {visit signin_path}

    it { should have_selector('h1', text: 'Sign-in') }
    it { should have_selector('title', text: "#{pre_title} Sign-in")}

    describe "Signing in with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('div.alert.alert-error', text: 'Invalid')}

      describe "and visiting another page" do
        before {click_link "help"}

        it {should_not have_selector('div.alert.alert-error')}
      end
    end

    describe "Signing in with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      #it { should have_selector('title', text: "#{pre_title} #{user.name} Profile")}
      #it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('sign-out', href: signout_path) }
      it { should_not have_link('sign-in', href: signin_path) }

      describe "followed by a signout" do
        before { click_link "sign-out"}

        it {should have_link("sign-in")}
      end
    end
  end

end
