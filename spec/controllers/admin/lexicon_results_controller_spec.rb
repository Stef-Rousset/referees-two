require 'rails_helper'

RSpec.describe Admin::LexiconResultsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let(:contributor) { create(:user, :contributor) }
  let(:normal) { create(:user, :normal) }
  let(:intern) { create(:user, :intern) }
  let(:lexicon) { create(:lexicon, :valid) }

  context 'not signed in' do
    it 'should not access index' do
      get :index
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end
  end

  context 'signed in as normal user' do
    before do
      sign_in normal
    end

    it 'should not access index' do
      get :index
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end

  context 'signed in as intern user' do
    before do
      sign_in intern
    end

    it 'should not access index' do
      get :index
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
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

  context "signed_in as contributor" do
    before do
      sign_in contributor
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end
  end
end
