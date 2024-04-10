require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  before(:example) do
    @user = create(:user, :admin)
    @question = create(:question, :valid, user: @user)
    @dep_f = create(:question, :dep_f, user: @user)
  end

  context 'not signed in' do
    it 'should access qcm page' do
      get :qcm, params: { level: "départemental", category: "fleuret" }
      assert_response :success
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'should not access dashboard' do
      get :dashboard
      assert_redirected_to new_user_session_path
    end

    it 'should not access new' do
      get :new
      assert_redirected_to new_user_session_path
    end

    it 'should not access show' do
      get :show, params: { id: @question }
      assert_redirected_to new_user_session_path
    end
  end

  context "signed_in" do
    before do
      sign_in @user
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'should access qcm page' do
      get :qcm, params: { level: "départemental", category: "fleuret" }
      assert_response :success
    end

    it 'should access dashboard' do
      get :dashboard
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
      assert_redirected_to question_path(Question.last)
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
      assert_redirected_to question_path(@question)
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
      assert_redirected_to root_path
    end
  end
end
