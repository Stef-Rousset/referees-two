# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  explanation :text             not null
#  good_prop   :integer          not null
#  question_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Answer, type: :model do
  before(:example) do
    @user = create(:user, :admin)
    @question = create(:question, :valid, user: @user)
    @valid = create(:answer, :valid, question: @question)
  end

  it 'should be invalid if one mandatory field is absent' do
    invalid = build(:answer, :empty_explanation, question: @question)
    expect(invalid).not_to be_valid
  end

  it 'should be invalid if explanation is too short' do
    invalid = build(:answer, :too_short_explanation, question: @question)
    expect(invalid).not_to be_valid
  end

  it 'should be valid if all mandatory fields are present' do
    expect(@valid).to be_valid
  end
end
