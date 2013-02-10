# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before { @user = User.new(email: "example@email.com", name: "Some User",
                                            password: "fizzle", password_confirmation: "fizzle") }
  subject { @user }

  it "Should respond to all fields" do
    should respond_to(:email)
    should respond_to(:name)
    should respond_to(:password_digest)
    should respond_to(:password)
    should respond_to(:password_confirmation)
  end

  it "should be valid" do
    should be_valid
  end

  describe "when a user has no name" do
    before {@user.name = " "}
    subject {@user}

    it { should_not be_valid }
  end

  #EMAIL
  describe "when a user doesn't have an email" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when an name is too long" do
    before {@user.name = "a" * 51 }
    it { should_not be_valid}
  end

  describe "when an email is invalid" do
    it "should be invalid" do
      addresses = %w[with@acomma,com
                                without.atsign.org
                                withno@ending
                                with@an_underscore.com
                                and@has_a+sign.com]

      addresses.each do |a|
        @user.email = a
        @user.should_not be_valid
      end
    end
  end

  describe "when an email is valid" do
    it "should be valid" do
      addresses = %w[one_with-dash@and.underscores.com
                                UPPER.CASE@ALL.COM
                                with+signs@inthebeginning.com]
    end
  end

  describe "when an email already exists" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

      it { should_not be_valid }
  end

  describe "value of email when saved" do
    before do
      @user.email = "IM_IN@UPPERCASE.COM"
      @user.save
    end

    it "should save to lowercase" do
      @user.email.should_not eq(@user.email.upcase)
    end
  end

  #Password
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "different_password" }

    it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
    before { @user.password_confirmation = nil}

    it { should_not be_valid }
  end

  #Authentication
  it { should respond_to(:authenticate) }
  describe "return the value of authentication method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with a valid password" do
      it {should == found_user.authenticate(@user.password) }
    end

    describe "with an invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it {should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end

    describe "with a password that is to short" do
      before { @user.password = @user.password_confirmation = "M" * 5}

      it {should be_invalid}
    end
  end

end