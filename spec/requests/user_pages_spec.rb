require 'spec_helper'

describe "UserPages" do
  describe "Signup Page" do
    before { visit signup_path }
    subject { page }
    it "Should have header Sign-up" do
      should have_selector("h1", text: "Sign-up")
    end
  end
end
