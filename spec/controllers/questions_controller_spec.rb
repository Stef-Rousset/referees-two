require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  before(:example) do
    @user = create(:user, :admin)
    @normal = create(:user, :normal)
    @question = create(:question, :valid, user: @user)
    @question_two = create(:question, :valid, user: @user)
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

    it 'should not access missed_questions' do
      get :missed_questions
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

    it 'should access qcm page' do
      get :qcm, params: { level: "départemental", category: "fleuret" }
      assert_response :success
    end

    it 'should access missed_questions' do
      get :missed_questions
      assert_response :success
    end

    it "should add a question to missed_questions" do
      get :add_failed_question, params: { id: @question }
      assert_response :ok
      expect(@user.failed_questions.count).to eq(1)
    end

    it "should delete a question from missed_questions" do
      @user.failed_questions << @question
      expect(@user.failed_questions.count).to eq(1)
      get :destroy_failed_question, params: { id: @question }
      assert_response :ok
      expect(@user.failed_questions.count).to eq(0)
    end

    it "should add questions to missed_questions" do
      expect(@user.failed_questions.count).to eq(0)
      get :add_failed_questions, params: { ids: "#{@question.id}, #{@question_two.id}" }
      assert_response :ok
      expect(@user.failed_questions.count).to eq(2)
    end

    it "should delete questions from missed_questions" do
      @user.failed_questions << @question
      @user.failed_questions << @question_two
      expect(@user.failed_questions.count).to eq(2)
      get :destroy_failed_questions, params: { ids: "#{@question.id}, #{@question_two.id}" }
      assert_response :ok
      expect(@user.failed_questions.count).to eq(0)
    end
  end

  context "sign in as normal user" do
    before do
      sign_in @normal
    end

    it 'should access index page' do
      get :index
      assert_response :success
    end

    it 'should access qcm page' do
      get :qcm, params: { level: "départemental", category: "fleuret" }
      assert_response :success
    end

    it 'should access missed_questions' do
      get :missed_questions
      assert_response :success
    end

    it "should add a question to missed_questions" do
      get :add_failed_question, params: { id: @question }
      assert_response :ok
      expect(@normal.failed_questions.count).to eq(1)
    end

    it "should delete a question from missed_questions" do
      @normal.failed_questions << @question
      expect(@normal.failed_questions.count).to eq(1)
      get :destroy_failed_question, params: { id: @question }
      assert_response :ok
      expect(@normal.failed_questions.count).to eq(0)
    end

    it "should add questions to missed_questions" do
      expect(@normal.failed_questions.count).to eq(0)
      get :add_failed_questions, params: { ids: "#{@question.id}, #{@question_two.id}" }
      assert_response :ok
      expect(@normal.failed_questions.count).to eq(2)

    end

    it "should delete questions from missed_questions" do
      @normal.failed_questions << @question
      @normal.failed_questions << @question_two
      expect(@normal.failed_questions.count).to eq(2)
      get :destroy_failed_questions, params: { ids: "#{@question.id}, #{@question_two.id}" }
      assert_response :ok
      expect(@normal.failed_questions.count).to eq(0)
    end
  end
end
