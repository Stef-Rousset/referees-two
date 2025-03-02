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
      # verify that there is 3 missed questions
      questions = find('div.qcm-general-questions')
      within questions do
        expect(all('form').count).to eq(3) # find all matching elements and count them
      end
    end

    # après 2 bonnes réponses et une mauvaise, verifier que modale
    # après clic sur voir la corrections, verifier les couleurs..
    # quand retour sur missed questions, vérifier qu'il n'en reste qu'une
  end
end
