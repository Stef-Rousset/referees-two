require 'rails_helper'

RSpec.describe "Lexicon qcm", type: :system do

  # redéfinit dans le test le helper car allow ne fonctionne pas
  module LexiconsHelper
    def month_beginning
      true
    end
  end

  context "type of lexicons in qcm" do
      let(:intern) { create(:user, :intern) }
      let!(:basics) { create_list(:lexicon, 8, :basics) }
      let!(:answers_basics) { build_list(:lexicon_answer, 8, :valid) do |answer, index|
                                answer.lexicon = basics[index]
                                answer.save!
                              end
                            }
      let!(:actions) { create_list(:lexicon, 10, :valid) }
      let!(:answers_act) { build_list(:lexicon_answer, 10, :valid) do |answer, index|
                              answer.lexicon = actions[index]
                              answer.save!
                            end
                          }
      let!(:prep) { create_list(:lexicon, 10, :prep) }
      let!(:answers_prep) { build_list(:lexicon_answer, 10, :valid) do |answer, index|
                              answer.lexicon = prep[index]
                              answer.save!
                            end
                          }
      let!(:other) { create_list(:lexicon, 5, :other) }
      let!(:answers_oth) { build_list(:lexicon_answer, 5, :valid) do |answer, index|
                              answer.lexicon = other[index]
                              answer.save!
                            end
                          }
    before do
      sign_in intern
      allow_any_instance_of(LexiconPolicy).to receive(:qcm?).and_return(true)
      #allow(ApplicationController.helpers).to receive(:month_beginning).and_return(true)
      #allow(LexiconsHelper).to receive(:month_beginning).and_return(true)
    end

    it 'shows a qcm with 5 basics, 8 actions, 4 prep and 3 other' do
      visit root_path
      click_link_or_button("QCM-Lexique")
      expect(page).to have_content("Qcm sur le Lexique")
      # verify that there is 2 rules questions
      expect(page).to have_selector('form[data-category="basics"]', count: 5)
      # ou expect(all('form[data-category="rules"]').count).to eq(2) # find all matching elements and count them
      # verify that there is 8 actions questions
      expect(page).to have_selector('form[data-category="actions"]', count: 8)
      # verify that there is 7 prep questions
      expect(page).to have_selector('form[data-category="prep"]', count: 4)
      # verify that there is 3 other questions
      expect(page).to have_selector('form[data-category="other"]', count: 3)
    end
  end

  context "answer" do
    let!(:intern) { create(:user, :intern) }
    let(:lexicon) { create(:lexicon, :valid) }
    let!(:answer) { create(:lexicon_answer, :valid, lexicon: lexicon ) } # good_prop is answer one

    before do
      sign_in intern
      allow_any_instance_of(LexiconPolicy).to receive(:qcm?).and_return(true)
    end

    context "when valid answer" do
      it "shows the good answer in green and gives explanation" do
        visit qcm_lexicons_path
        find('input[value=un]').click # click on good answer
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 1 bonne(s) réponse(s) sur 20 questions")
        click_link_or_button "Voir la correction du QCM"
        expect(page).to have_css('input[value=un].green')
        expect(page).to have_css('input[value=deux].blue')
        expect(page).to have_css('input[value=trois].blue')
        click_link_or_button "Retour à l'accueil"
        expect(page).to have_content("L'objectif de ce site est de vous permettre de vous entraîner au qcm d'arbitrage")
      end
    end

    context "when wrong answer" do
      it "shows the wrong answer in red and gives explanation" do
        visit qcm_lexicons_path
        find('input[value=deux]').click # click on wrong answer
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 0 bonne(s) réponse(s) sur 20 questions")
        click_link_or_button "Voir la correction du QCM"
        expect(page).to have_css('input[value=un].blue')
        expect(page).to have_css('input[value=deux].red') # wrong answer in red
        expect(page).to have_css('input[value=trois].blue')
        expect(page).to have_content('La bonne réponse est la réponse un')
      end
    end
  end
end
