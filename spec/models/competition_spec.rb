require "rails_helper"

RSpec.describe Competition, type: :model do
  before(:each) do
    @competition = build(:competition_with_only_one_attempt)
  end

  it "is valid with a name" do
    expect(@competition).to be_valid
  end

  it "is not valid without a name" do
    @competition.name = nil
    expect(@competition).to_not be_valid
  end

  it "is not valid with a blank name" do
    @competition.name = ''
    expect(@competition).to_not be_valid
  end

  it "is not valid without a unique name" do
    @competition.save
    same_name_competition = build(:competition_with_only_one_attempt)
    expect(same_name_competition).to_not be_valid
  end

  it "is not valid without an unit" do
    @competition.unit = nil
    expect(@competition).to_not be_valid
  end

  it "is not finished by default" do
    expect(@competition.finished).to eq(false)
  end

  it "is not valid without a criteria to win" do
    @competition.criteria_to_win = nil
    expect(@competition).to_not be_valid
  end

  it "has max as the criteria to win by default" do
    expect(@competition.criteria_to_win).to eq("max")
  end

  it "is not valid if the criteria to win is different from min or max" do
    @competition.criteria_to_win = "faster"
    expect(@competition).to_not be_valid
  end

  it "is not valid without the maximum number of attempts" do
    @competition.max_number_of_attempts = nil
    expect(@competition).to_not be_valid
  end

  it "has 1 as the maximum number of attempts by default" do
    expect(@competition.max_number_of_attempts).to eq(1)
  end

  it "is not valid if the maximum number of attempts is not a number" do
    @competition.max_number_of_attempts = "Hey I am not a number"
    expect(@competition).to_not be_valid
  end

  it "is not valid if the maximum number of attempts is not an integer" do
    @competition.max_number_of_attempts = 3.5
    expect(@competition).to_not be_valid
  end

  it "is not valid if the maximum number of attempts is not a positive integer" do
    @competition.max_number_of_attempts = -2
    expect(@competition).to_not be_valid
  end
end
