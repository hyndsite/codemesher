# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Group do
  before {@group = FactoryGirl.build(:group)}
  subject {@group}

  describe "responds to" do

    it {should respond_to(:name)}
    it {should respond_to(:users)}
  end

  describe "without a name" do
    before do
      @group.name = nil
      @group.save
    end

    it {should_not be_valid}
  end

  describe "with invalid name" do
    describe "with more than 25 characters" do
      before {@group.name = "a" * 30}
      it {should_not be_valid}
    end

    describe "with less than 3 characters" do
      before {@group.name = @group.name[0..1] }
      it {should_not be_valid}
    end
  end

  describe "does not allow duplicates" do
    before do
      @group.save
      @group_with_same_name = @group.dup
      @group_with_same_name.save
    end

    it {@group_with_same_name.should_not be_valid}
  end

  #invalid group
  #valid characters $[a-Z, 1-9, -_+.]^
  describe "with invalid name" do
    it "should be invalid" do
      names = %w[! @ # $ % ^ & * ( ) = < > ? / \[ \] \\ | ].map {|x| "with#{x}"}

      names.each do |name|
        @group.name = name
        @group.should_not be_valid
      end
    end
  end

  describe "with valid name" do
    before {@group.save}

    it {should be_valid}
  end

end
