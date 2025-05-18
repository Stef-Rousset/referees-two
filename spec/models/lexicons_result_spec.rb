require 'rails_helper'

RSpec.describe LexiconsResult, type: :model do
  let(:user) { create(:user, :normal) }
  let(:second_user) { create(:user, :intern) }
  let!(:lexicons_results) { create_list(:lexicons_result, 3, :valid, user: user) }
  let!(:lexicons_result_one) { create(:lexicons_result, :valid, user: user) }
  let!(:lexicons_result_two) { create(:lexicons_result, :valid, user: second_user) }

  it "is valid" do
    expect(build(:lexicons_result, :valid, user: user)).to be_valid
  end

  it "is not valid if score is empty" do
    expect(build(:lexicons_result, :empty_score, user: user)).not_to be_valid
  end

  it "is not valid if score is not a number" do
    expect(build(:lexicons_result, :not_number_score, user: user)).not_to be_valid
  end

  it "is not valid if score is less than 0" do
    expect(build(:lexicons_result, :score_less_than_zero, user: user)).not_to be_valid
  end

  it "is not valid if score is greater than 20" do
    expect(build(:lexicons_result, :score_greather_than_twenty, user: user)).not_to be_valid
  end

  it "gives the results from user" do
    expect(LexiconsResult.results(user.email).count).to eq(4)
    expect(LexiconsResult.results(user.email)).to include(lexicons_result_one)
    expect(LexiconsResult.results(user.email)).not_to include(lexicons_result_two)
  end

  it "gives the score for the specific month" do
    # month for the created_at of the results
    month = DateTime.now.month
    expect(LexiconsResult.results(user.email).month_score(month)).to eq(18) # score of valid is 18
    expect(LexiconsResult.results(user.email).month_score(1)).to eq(nil)
  end
end
