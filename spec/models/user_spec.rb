require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @admin = create(:user, :admin)
  end

  it 'should be invalid if email is not unique' do
    user = User.new(email: @admin.email, password: "test123")
    expect(user.valid?).to eq(false)
  end

  it 'should be invalid if email is not valid' do
    user = User.new(email: "paul.com", password: "test123")
    expect(user.valid?).to eq(false)
  end

  it 'should be valid if email is unique and valid' do
    user = User.new(email: "bla@gmail.com", password: "test123")
    expect(user.valid?).to eq(true)
  end

  it 'should have a default role of normal when created without role' do
    user = User.create!(email: "marc@gmail.com", password: "test123")
    expect(user.role).to eq("normal")
  end
end
