require 'rails_helper'

RSpec.describe "Questions", type: :system do
  before(:example) do
    @user = create(:user, :admin)
    @question = create(:question, :valid, user: @user)
    @answer = create(:answer, :valid, question: @question)
    @questionbis = create(:question, :dep_g, user: @user)
    @answerbis = create(:answer, :valid, question: @questionbis)
  end

  it 'shows good answer in index page when correct answer is selected' do
    visit root_path
    expect(page).to have_content("L'objectif de ce site")
    click_on("Sélectionner des questions")
    expect(page).to have_content('Choix du type de question')
    choose("category_g_n_ralit_s") #radio button, with id
    choose("level_d_partemental")
    click_on("Commencer")
    expect(page).to have_content("questions de niveau départemental, catégorie généralités")
    find('input[data-value="un"]').click #good prop are "un" for @answer and @answerbis
    click_on('Valider')
    expect(page).to have_content('Bonne réponse !')
  end

  it 'shows bad answer in index page when bad answer is selected' do
    visit root_path
    expect(page).to have_content("L'objectif de ce site")
    click_on("Sélectionner des questions")
    expect(page).to have_content('Choix du type de question')
    choose("category_g_n_ralit_s") #radio button, with id
    choose("level_d_partemental")
    click_on("Commencer")
    expect(page).to have_content("questions de niveau départemental, catégorie généralités")
    find('input[data-value="deux"]').click #good prop is "un" for @answer
    click_on('Valider')
    expect(page).to have_content('Mauvaise réponse...')
    expect(page).to have_content('La bonne réponse est')
  end

  it 'shows questions with btns previous and next' do
    visit root_path
    expect(page).to have_content("L'objectif de ce site")
    click_on("Sélectionner des questions")
    expect(page).to have_content('Choix du type de question')
    choose("category_g_n_ralit_s") #radio button, with id
    choose("level_d_partemental")
    click_on("Commencer")
    save_and_open_page
    expect(page).to have_content("questions de niveau départemental, catégorie généralités")
    # il y a 2 questions
    expect(find(".disabled")).to have_text('Précédent') # previous est disabled
    click_on("Suivant")  # next est fonctionnel
    expect(find(".disabled")).to have_text('Suivant') # plus de question, next est disabled
    click_on("Précédent") # previous est fonctionnel
  end
end
