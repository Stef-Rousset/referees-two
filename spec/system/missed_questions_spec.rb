require 'rails_helper'

RSpec.describe "Missed questions", type: :system do

  context "visiting missed_questions page without missed questions" do
    let(:user){ create(:user, :normal) }

    before do
      # sign in as user
      sign_in user
    end

    it "displays a specific message and no questions" do
      visit missed_questions_path
      expect(page).to have_content("Il n'y a pas de questions auxquelles vous auriez répondu de manière incorrecte")
      expect(page).not_to have_css('form')
    end
  end

  context "visiting missed_questions page with 3 missed questions" do
    let(:admin) { create(:user, :admin) }
    let(:user){ create(:user, :normal) }
    let(:questions) { create_list(:question, 3, :dep_g, user: admin) }
    let!(:answers) { build_list(:answer, 3, :valid) do |answer, index|
                            answer.question = questions[index]
                            answer.save!
                          end
                    }

    before do
      # create missed questions
      questions.each do |question|
        user.failed_questions << question
      end

      sign_in user
    end

    it "displays 3 missed_questions" do
      visit missed_questions_path
      expect(page).to have_content("3 questions à revoir")
      # verify that data-count attribute is 3
      expect(find('h2[data-missed-results-target]')['data-count']).to eq("3")
      # verify that there are 3 missed questions
      questions = find('div.qcm-general-questions')
      within questions do
        expect(all('form').count).to eq(3) # find all matching elements and count them
      end
    end
  end

  context "answering one missed question" do
    let(:admin) { create(:user, :admin) }
    let(:user){ create(:user, :normal) }
    let(:question) { create(:question, :dep_g, user: admin) }
    let!(:answer) { create(:answer, :valid, question: question) } # good_prop is answer one


    before do
      # create missed question
      user.failed_questions << question
      sign_in user
    end

    context "when valid answer" do
      it "shows the good answer in green and gives explanation" do
        visit missed_questions_path
        data_ge = find('div.qcm-general-questions')
        within data_ge do
          find('input[value=un]').click # click on good answer
        end
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 1 bonne(s) réponse(s)")
        click_link_or_button "Voir la correction des questions"
        within data_ge do
          expect(page).to have_css('input[value=un].green')
          expect(page).to have_css('input[value=deux].blue')
          expect(page).to have_css('input[value=trois].blue')
        end
        expect(page).to have_content('réponse exacte')
        click_link_or_button "Retour à l'accueil"
        expect(page).to have_content("L'objectif de ce site est de vous permettre de vous entraîner au qcm d'arbitrage")
      end
    end

    context "when wrong answer" do
      it "shows the wrong answer in red and gives explanation" do
        visit missed_questions_path
        data_ge = find('div.qcm-general-questions')
        within data_ge do
          find('input[value=deux]').click # click on wrong answer
        end
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 0 bonne(s) réponse(s)")
        click_link_or_button "Voir la correction des questions"
        within data_ge do
          expect(page).to have_css('input[value=un].blue')
          expect(page).to have_css('input[value=deux].red') # wrong answer in red
          expect(page).to have_css('input[value=trois].blue')
        end
        expect(page).to have_content('La bonne réponse est la réponse un')
        expect(page).to have_content('réponse exacte')
      end
    end
  end
  # à ajouter, quand 3 questions à revoir, 2 bonnes réponses et qu'on revient
  # sur questions à revoir, reste une question
end
