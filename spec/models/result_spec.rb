require "rails_helper"

RSpec.describe Result, type: :model do
  before(:each) do
    @result = build(:result_from_competition_with_only_one_attempt)
  end

  it "is not valid without an athlete" do
    @result.athlete = nil
    expect(@result).to_not be_valid
  end

  it "is not valid without a competition" do
    @result.competition = nil
    expect(@result).to_not be_valid
  end

  it "is not valid without a value" do
    @result.value = nil
    expect(@result).to_not be_valid
  end

  it "is not valid if the value is not a number" do
    @result.value = "Hey I am not a number"
    expect(@result).to_not be_valid
  end

  it "is not valid if the value is a negative number" do
    @result.value = -12
    expect(@result).to_not be_valid
  end

  it "is not valid if the competition is finished" do
    @result.competition.finished = true
    expect(@result).to_not be_valid
  end
end

describe "Result from competition with only one attempt" do
  before(:each) do
    @result = build(:result_from_competition_with_only_one_attempt)
  end

  it "cannot be added if the athlete already made his attempt" do
    @result.save
    new_attempt = Result.new(competition: @result.competition,
                            athlete: @result.athlete,
                            value: 11.2)
    expect(new_attempt).to_not be_valid
  end
end

describe "Result from competition with several attempts" do
  before(:each) do
    @result = build(:result_from_competition_with_several_attempts)
  end

  it "can be added if the athlete still has available attempt(s)" do
    @result.save
    new_attempt = Result.new(competition: @result.competition,
                            athlete: @result.athlete,
                            value: 91.79)
    expect(new_attempt).to be_valid
  end
end
