require 'rails_helper'

RSpec.describe Admin::AdminController, type: :controller do
  before(:example) do
    @user = create(:user, :admin)
    @normal = create(:user, :normal)
    @question = create(:question, :valid, user: @user)
    @question_two = create(:question, :valid, user: @user)
    @dep_f = create(:question, :dep_f, user: @user)
  end

  context "when not signed in" do
    it "should not acces index" do
      get :index
      assert_redirected_to '/users/sign_in'
      expect(flash[:alert]).to match("Vous devez vous connecter ou vous inscrire pour continuer")
    end
  end

  context "when signed in as normal user" do
    before do
      sign_in @normal
    end

    it "should not acces index" do
      get :index
      expect(flash[:alert]).to match("Vous n'êtes pas autorisé à réaliser cette action.")
    end
  end

  context "when signed in as admin" do
    before do
      sign_in @user
    end

    it "should acces index" do
      get :index
      assert_response :success
    end
  end
end
