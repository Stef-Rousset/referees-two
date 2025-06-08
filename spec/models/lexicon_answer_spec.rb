# == Schema Information
#
# Table name: lexicon_answers
#
#  id         :bigint           not null, primary key
#  good_prop  :integer          not null
#  lexicon_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe LexiconAnswer, type: :model do
  let(:lexicon) { create(:lexicon, :valid) }

  it "is valid when answer is valid" do
    expect(build(:lexicon_answer, :valid, lexicon: lexicon)).to be_valid
  end

  it "is invalid if good_prop is empty" do
    expect(build(:lexicon_answer, :invalid, lexicon: lexicon)).not_to be_valid
  end
end
