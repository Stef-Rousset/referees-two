require 'rails_helper'

RSpec.describe LexiconResult, type: :model do
  let(:user) { create(:user, :normal) }
  let(:second_user) { create(:user, :intern) }
  let!(:lexicon_results) { create_list(:lexicon_result, 3, :valid, user: user) }
  let!(:lexicon_result_one) { create(:lexicon_result, :valid, user: user) }
  let!(:lexicon_result_two) { create(:lexicon_result, :valid, user: second_user) }

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

  it "gives the results from user" do
    expect(LexiconResult.results(user.email).count).to eq(4)
    expect(LexiconResult.results(user.email)).to include(lexicon_result_one)
    expect(LexiconResult.results(user.email)).not_to include(lexicon_result_two)
  end

  it "gives the score for the specific month" do
    # month for the created_at of the results
    month = DateTime.now.month
    expect(LexiconResult.results(user.email).month_score(month)).to eq(18) # score of valid is 18
    expect(LexiconResult.results(user.email).month_score(1)).to eq(nil)
  end
end
