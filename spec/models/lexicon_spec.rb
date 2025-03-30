require 'rails_helper'

RSpec.describe Lexicon, type: :model do
  let!(:prep_hab) { create(:lexicon, :prep_hab) }
  let!(:rules) { create(:lexicon, :rules) }

  it "is valid" do
    expect(build(:lexicon, :valid)).to be_valid
  end

  it "is not valid if statement is too short" do
    expect(build(:lexicon, :invalid_statement)).not_to be_valid
  end

  it "is not valid if category is missing" do
    expect(build(:lexicon, :missing_category)).not_to be_valid
  end

  it "renders lexicons from chosen category when filtering by category" do
    expect(Lexicon.filter_by_category("rules").size).to eq(1)
    expect(Lexicon.filter_by_category("rules")).not_to include(prep_hab)
    expect(Lexicon.filter_by_category("rules")).to include(rules)
  end
end
