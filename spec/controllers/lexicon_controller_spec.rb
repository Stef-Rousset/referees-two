require 'rails_helper'

RSpec.describe LexiconsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let(:normal) { create(:user, :normal) }

  context 'not signed in' do
    it 'should access index page' do
      get :index
      assert_response :success
    end
  end

  context "signed_in as admin" do
    before do
      sign_in user
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end
  end

  context "sign in as normal user" do
    before do
      sign_in normal
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end
  end
end
