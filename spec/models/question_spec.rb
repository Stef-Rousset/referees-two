require 'rails_helper'

RSpec.describe Question, type: :model do
  before(:example) do
    @user = create(:user, :admin)
    @valid = create(:question, :valid, user: @user)
    @valid_reg = create(:question, :reg_g, user: @user)
  end

  it 'should be invalid if one mandatory field is absent' do
    invalid = build(:question, :empty_statement, user: @user)
    expect(invalid).not_to be_valid
  end

  it 'should be invalid if statement length is less than 2' do
    invalid = build(:question, :too_short_statement, user: @user)
    expect(invalid).not_to be_valid
  end

  it 'should be valid if all mandatory fields are present and length is ok' do
    expect(@valid).to be_valid
  end

  it 'should return question level "départemental" and category "généralités" ' do
    dep_f = create(:question, :dep_f, user: @user)
    expect(Question.dep_g).not_to include(dep_f)
    expect(Question.dep_g).to include(@valid)
  end

  it 'should return question level "départemental" and category "fleuret" ' do
    dep_f = create(:question, :dep_f, user: @user)
    expect(Question.dep_f).to include(dep_f)
    expect(Question.dep_f).not_to include(@valid)
  end

  it 'should return question level "départemental" and category "épée" ' do
    dep_e = create(:question, :dep_e, user: @user)
    expect(Question.dep_e).to include(dep_e)
    expect(Question.dep_e).not_to include(@valid)
  end

  it 'should return question level "départemental" and category "sabre" ' do
    dep_s = create(:question, :dep_s, user: @user)
    expect(Question.dep_s).to include(dep_s)
    expect(Question.dep_s).not_to include(@valid)
  end

  it 'should return question level "régional" and category "généralités" ' do
    reg_f = create(:question, :reg_f, user: @user)
    expect(Question.reg_g).to include(@valid_reg)
    expect(Question.reg_g).not_to include(reg_f)
  end

  it 'should return question level "régional" and category "fleuret" ' do
    reg_f = create(:question, :reg_f, user: @user)
    expect(Question.reg_f).to include(reg_f)
    expect(Question.reg_f).not_to include(@valid_reg)
  end

  it 'should return question level "régional" and category "épée" ' do
    reg_e = create(:question, :reg_e, user: @user)
    expect(Question.reg_e).to include(reg_e)
    expect(Question.reg_e).not_to include(@valid_reg)
  end

  it 'should return question level "régional" and category "sabre" ' do
    reg_s = create(:question, :reg_s, user: @user)
    expect(Question.reg_s).to include(reg_s)
    expect(Question.reg_s).not_to include(@valid_reg)
  end

  it 'should return questions with level "départemental" only' do
    expect(Question.filter_by_level("départemental")).to include(@valid)
    expect(Question.filter_by_level("départemental")).not_to include(@valid_reg)
  end

  it 'should return questions with caté "généralités" only' do
    reg_s = create(:question, :reg_s, user: @user)
    expect(Question.filter_by_category("généralités")).to include(@valid)
    expect(Question.filter_by_category("généralités")).to include(@valid_reg)
    expect(Question.filter_by_category("généralités")).not_to include(reg_s)
  end
end
