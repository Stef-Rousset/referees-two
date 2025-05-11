require 'rails_helper'

RSpec.describe LexiconResult, type: :model do
  let(:user) { create(:user, :normal) }

  it "is valid" do
    expect(build(:lexicon_result, :valid, user: user)).to be_valid
  end

  it "is not valid if score is empty" do
    expect(build(:lexicon_result, :empty_score, user: user)).not_to be_valid
  end

  it "is not valid if score is not a number" do
    expect(build(:lexicon_result, :not_number_score, user: user)).not_to be_valid
  end

  it "is not valid if score is less than 0" do
    expect(build(:lexicon_result, :score_less_than_zero, user: user)).not_to be_valid
  end

  it "is not valid if score is greater than 20" do
    expect(build(:lexicon_result, :score_greather_than_twenty, user: user)).not_to be_valid
  end
end
