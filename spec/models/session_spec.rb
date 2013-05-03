require 'spec_helper'

describe Session do
  before {@session = FactoryGirl.create(:session)}
  subject {@session}

  it {should respond_to(:abstract, :finish, :level, :room, :start, :title, :track)}
  it {should be_valid}
end
