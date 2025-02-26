require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before(:example) do
    @user = create(:user, :admin)
    @question = create(:question, :valid, user: @user)
    @answer = create(:answer, :valid, question: @question)
  end

  context "when not logged in" do
    it 'shows home page and get access to question index' do
      visit root_path
      expect(page).to have_content("L'objectif de ce site")
      click_on("Sélectionner des questions")
      expect(page).to have_content('Choix du type de question')
      choose("category_g_n_ralit_s") #radio button, with id
      choose("level_d_partemental")
      click_on("Commencer")
      expect(page).to have_content("questions de niveau départemental, catégorie généralités")
    end

    it 'shows home page and get access to qcm' do
      visit root_path
      expect(page).to have_content("L'objectif de ce site")
      click_on("QCM complet chronométré")
      expect(page).to have_content('Choix du type de QCM')
      choose("category_fleuret") #radio button, with id
      choose("level_d_partemental")
      click_on("Commencer")
      expect(page).to have_content("Qcm départemental spécifique fleuret")
    end

    it "get access to ressources from home" do
      visit root_path
      expect(page).to have_content("L'objectif de ce site")
      click_link('ressources_link') #id du link
      expect(page).to have_content('Documentation à consulter')
    end

    it "does not have access to missed_questions" do
      visit root_path
      expect(page).not_to have_content("Revoir les questions où j'ai mal répondu")
    end
  end

  context "when logged in" do
    before do
      sign_in @user
    end

    it "get access to missed_questions and can return to home page" do
      visit root_path
      expect(page).to have_content("Revoir les questions où j'ai mal répondu")
      click_link_or_button("Revoir les questions où j'ai mal répondu")
      expect(page).to have_content("Il n'y a pas de questions auxquelles vous auriez répondu de manière incorrecte")
      click_link_or_button "Retour à l'accueil"
      expect(page).to have_content("L'objectif de ce site est de vous permettre de vous entraîner au qcm d'arbitrage")
    end
  end
end
