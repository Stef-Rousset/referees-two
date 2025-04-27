require 'rails_helper'

RSpec.describe Admin::LexiconsController, type: :controller do
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

    it 'should not access new' do
      get :new
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end

    it 'should not access show' do
      get :show, params: { id: lexicon }
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end

    it 'should not access edit' do
      get :edit, params: { id: lexicon }
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

    it 'should not access new' do
      get :new
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access show' do
      get :show, params: { id: lexicon }
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access edit' do
      get :edit, params: { id: lexicon }
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

    it 'should not access new' do
      get :new
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access show' do
      get :show, params: { id: lexicon }
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access edit' do
      get :edit, params: { id: lexicon }
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

    it 'should access show' do
      get :show, params: { id: lexicon }
      assert_response :success
    end

    it 'should access new' do
      get :new
      assert_response :success
    end

    it 'should access edit' do
      get :edit, params: { id: lexicon }
      assert_response :success
    end

    it 'should create a lexicon question' do
      post :create, params: { lexicon: { statement: 'super question', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être', category: "rules" } }
      assert_redirected_to admin_lexicon_path(Lexicon.last)
    end

    it 'respond with 422 if create fails' do
      post :create, params: { lexicon: { statement: '', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être', category: "rules" } }
      assert_response :unprocessable_entity
    end

    it 'should update a lexicon question' do
      put :update, params: { id: lexicon.id,
                             lexicon: { statement: 'question pertinente' }
                            }
      assert_redirected_to admin_lexicon_path(lexicon)
      expect(lexicon.reload.statement).to eq('question pertinente')
    end

    it 'responds with 422 if update fails' do
      put :update, params: { id: lexicon.id,
                             lexicon: { statement: '' }
                            }
      assert_response :unprocessable_entity
    end

    it 'should destroy a lexicon question' do
      delete :destroy, params: { id: lexicon }
      assert_redirected_to admin_lexicons_path
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

    it 'should access show' do
      get :show, params: { id: lexicon }
      assert_response :success
    end

    it 'should access new' do
      get :new
      assert_response :success
    end

    it 'should access edit' do
      get :edit, params: { id: lexicon }
      assert_response :success
    end

    it 'should create a lexicon question' do
      post :create, params: { lexicon: { statement: 'super question', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être', category: "rules" } }
      assert_redirected_to admin_lexicon_path(Lexicon.last)
    end

    it 'respond with 422 if create fails' do
      post :create, params: { lexicon: { statement: '', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être', category: "rules" } }
      assert_response :unprocessable_entity
    end

    it 'should update a lexicon question' do
      put :update, params: { id: lexicon.id,
                             lexicon: { statement: 'question pertinente' }
                            }
      assert_redirected_to admin_lexicon_path(lexicon)
      expect(lexicon.reload.statement).to eq('question pertinente')
    end

    it 'responds with 422 if update fails' do
      put :update, params: { id: lexicon.id,
                             lexicon: { statement: '' }
                            }
      assert_response :unprocessable_entity
    end

    it 'should destroy a lexicon question' do
      delete :destroy, params: { id: lexicon }
      assert_redirected_to admin_lexicons_path
    end
  end
end
