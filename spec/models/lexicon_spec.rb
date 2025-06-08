# == Schema Information
#
# Table name: lexicons
#
#  id         :bigint           not null, primary key
#  statement  :text             not null
#  prop_one   :text             not null
#  prop_two   :text             not null
#  prop_three :text             not null
#  category   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Lexicon, type: :model do
  let!(:prep) { create(:lexicon, :prep) }
  let!(:basics) { create(:lexicon, :basics) }

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
    expect(Lexicon.filter_by_category("basics").size).to eq(1)
    expect(Lexicon.filter_by_category("basics")).not_to include(prep)
    expect(Lexicon.filter_by_category("basics")).to include(basics)
  end
end
