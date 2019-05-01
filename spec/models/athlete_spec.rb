require "rails_helper"

RSpec.describe Athlete, type: :model do
  before(:each) do
    @athlete = build(:athlete)
  end

  it "is valid with a name" do
    expect(@athlete).to be_valid
  end

  it "is not valid without a name" do
    @athlete.name = nil
    expect(@athlete).to_not be_valid
  end

  it "is not valid with a blank name" do
    @athlete.name = ''
    expect(@athlete).to_not be_valid
  end

  it "is not valid without a unique name" do
    @athlete.save
    same_name_athlete = build(:athlete)
    expect(same_name_athlete).to_not be_valid
  end
end
