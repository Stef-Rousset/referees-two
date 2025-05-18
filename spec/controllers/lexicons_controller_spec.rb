require 'rails_helper'

RSpec.describe LexiconsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let(:normal) { create(:user, :normal) }
  let(:intern) { create(:user, :intern) }

  context 'not signed in' do
    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'should not access qcm page' do
      get :qcm
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end

    it 'should not access add_lexicon_result' do
      post :add_lexicon_result, params: { score: 18 }
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
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

    it 'should access qcm page' do
      get :qcm
      assert_response :success
    end

    it 'should access add_lexicon_result' do
      post :add_lexicon_result, params: { score: 18 }
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

    it 'should not access qcm page' do
      get :qcm
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access add_lexicon_result' do
      post :add_lexicon_result, params: { score: 18 }
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end

  context "sign in as intern user" do
    before do
      sign_in intern
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'access qcm page depending on current date' do
      get :qcm
      if DateTime.now.day >= 1 && DateTime.now.day < 16
        assert_response :success
      else
        expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
      end
    end

    it 'should access add_lexicon_result' do
      post :add_lexicon_result, params: { score: 18 }
      assert_response :success
    end
  end
end
