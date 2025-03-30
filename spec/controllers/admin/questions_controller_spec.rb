require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  before(:example) do
    @user = create(:user, :admin)
    @normal = create(:user, :normal)
    @question = create(:question, :valid, user: @user)
    @question_two = create(:question, :valid, user: @user)
    @dep_f = create(:question, :dep_f, user: @user)
  end

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
      get :show, params: { id: @question }
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end

    it 'should not access edit' do
      get :edit, params: { id: @question }
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end
  end

  context "signed_in as admin" do
    before do
      sign_in @user
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'should access show' do
      get :show, params: { id: @question }
      assert_response :success
    end

    it 'should access new' do
      get :new
      assert_response :success
    end

    it 'should access edit' do
      get :edit, params: { id: @question }
      assert_response :success
    end

    it 'should create a question' do
      post :create, params: { question: {
        statement: 'super question', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être',
        level: 'régional', category: 'fleuret', user_id: @user.id }
                            }
      assert_redirected_to admin_question_path(Question.last)
    end

    it 'respond with 422 if create fails' do
      post :create, params: { question: {
        statement: '', prop_one: 'vrai', prop_two: 'faux', prop_three: 'peut être',
        level: 'régional', category: 'fleuret', user_id: @user.id }
                            }
      assert_response :unprocessable_entity
    end

    it 'should update a question' do
      put :update, params: { id: @question.id,
                             question: { statement: 'question pertinente' }
                            }
      assert_redirected_to admin_question_path(@question)
      expect(@question.reload.statement).to eq('question pertinente')
    end

    it 'responds with 422 if update fails' do
      put :update, params: { id: @question.id,
                             question: { statement: '' }
                            }
      assert_response :unprocessable_entity
    end

    it 'should destroy a question' do
      delete :destroy, params: { id: @question }
      assert_redirected_to admin_questions_path
    end
  end

  context "sign in as normal user" do
    before do
      sign_in @normal
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
      get :show, params: { id: @question }
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access edit' do
      get :edit, params: { id: @question }
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end
end
