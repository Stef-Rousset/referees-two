require 'rails_helper'

RSpec.describe "Lexicons", type: :system do
  let(:lexicon) { create(:lexicon, :valid) }
  let(:basics) { create(:lexicon, :basics) }
  let!(:answer) { create(:lexicon_answer, :valid, lexicon: lexicon) }
  let!(:answer_two) { create(:lexicon_answer, :valid, lexicon: basics) }

  it 'shows good answer in index page when correct answer is selected' do
    visit root_path
    within "navbar" do
      click_link_or_button("Lexique")
    end
    expect(page).to have_content('questions de Lexique')
    find('input[data-value="un"]').click #good prop is "un" for answer
    click_link_or_button('Valider')
    expect(page).to have_content('Bonne réponse !')
  end

  it 'shows bad answer in index page when bad answer is selected' do
    visit lexicons_path
    expect(page).to have_content("questions de Lexique")
    find('input[data-value="deux"]').click #good prop is "un" for answer
    click_on('Valider')
    expect(page).to have_content('Mauvaise réponse...')
    expect(page).to have_content('La bonne réponse est')
  end

  it 'shows questions with btns previous and next' do
    visit lexicons_path
    expect(page).to have_content("questions de Lexique")
    # il y a 2 questions
    expect(find(".disabled")).to have_text('Précédent') # previous est disabled
    click_on("Suivant")  # next est fonctionnel
    expect(find(".disabled")).to have_text('Suivant') # plus de question, next est disabled
    click_on("Précédent") # previous est fonctionnel
  end
end
