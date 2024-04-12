require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before(:example) do
    @user = create(:user, :admin)
  end

  context 'not signed in' do
    it 'should access homepage' do
      get :home
      assert_response :success
    end

    it 'should access ressources page' do
      get :ressources
      assert_response :success
    end
  end

  context 'signed in' do
    before do
      sign_in @user
    end

    it 'should access homepage' do
      get :home
      assert_response :success
    end

    it 'should access ressources page' do
      get :ressources
      assert_response :success
    end
  end
end
