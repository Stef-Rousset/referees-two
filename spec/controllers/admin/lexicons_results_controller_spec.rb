require 'rails_helper'

RSpec.describe Admin::LexiconsResultsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let(:contributor) { create(:user, :contributor) }
  let(:normal) { create(:user, :normal) }
  let(:intern) { create(:user, :intern) }


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

    it 'should not access index with format html' do
      get :index, format: :html
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access index with format xlsx' do
      get :index, format: :xlsx
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end

  context 'signed in as intern user' do
    before do
      sign_in intern
    end

    it 'should not access index with format html' do
      get :index, format: :html
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end

    it 'should not access index with format xlsx' do
      get :index, format: :xlsx
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end

   context "signed_in as admin" do
    before do
      sign_in user
    end

    it 'should access index page with format html' do
      get :index, format: :html
      assert_response :success
    end

    it 'should access index page with format xlsx' do
      get :index, format: :xlsx
      assert_response :success
    end
  end

  context "signed_in as contributor" do
    before do
      sign_in contributor
    end

    it 'should access index page with format html' do
      get :index, format: :html
      assert_response :success
    end

    it 'should access index page with format xlsx' do
      get :index, format: :xlsx
      assert_response :success
    end
  end
end
