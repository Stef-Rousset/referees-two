require 'rails_helper'

RSpec.describe "Pages", type: :system do
  before(:example) do
    @user = create(:user, :admin)
    @question = create(:question, :valid, user: @user)
    @answer = create(:answer, :valid, question: @question)
  end

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

  it 'shows home page and get access to qcm ' do
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
end
