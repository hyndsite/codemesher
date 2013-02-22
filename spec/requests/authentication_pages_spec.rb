require 'spec_helper'

describe "Authentication_Pages: " do

  subject { page }

    describe "signin page" do
      before {visit signin_path}

      it { should have_selector('h1', text: 'Sign-in') }
      it { should have_selector('title', text: app_title("Sign-in"))}

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
        before {sign_in user}

        #it { should have_selector('title', text: "#{pre_title} #{user.name} Profile")}
        #it { should have_link('Profile', href: user_path(user)) }
        it { should have_link('sign-out', href: signout_path) }
        it { should_not have_link('sign-in', href: signin_path) }

        describe "followed by a signout" do
          before { click_link "sign-out"}

          it {should have_link("sign-in")}
        end
      end

      describe "authorization" do

          describe "for non-signed in users" do
            let(:user) {FactoryGirl.create(:user)}

              describe "when attempting to visit a protected page" do
                  before do
                    visit edit_user_path(user)
                    fill_in "Email", with: user.email.downcase
                    fill_in "Password", with: user.password
                    fill_in "Confirm Password", with: user.password_confirmation
                    click_button "Sign in"
                  end

                  describe "after signing in" do
                    it {should have_selector('title', text: app_title("Edit User"))}
                  end
              end

              describe "in the user controller" do

                  describe "visiting the edit page" do
                    before {visit edit_user_path(user)}
                    it { should_not have_selector('title', text: app_title("Edit User"))}
                  end

                  describe "submitting to the update action" do
                    before { put user_path(user)}
                    specify { response.should redirect_to(signin_path)}
                  end
              end
          end

          describe  "as the wrong user" do
            let(:user) {FactoryGirl.create(:user)}
            let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@email.com")}
            before {sign_in user}

            describe "visit Users#edit page" do
              before {visit edit_user_path(wrong_user)}

              it {should_not have_selector('title', text: app_title('Edit User'))}
            end

            describe "submitting a PUT request to Users#update action" do
              before {put user_path(wrong_user)}

               specify {response.should redirect_to(root_path)}
            end
          end
      end
  end
end
