require 'rails_helper'

RSpec.describe "Qcm", type: :system do

  context "with level departemental" do
      let(:user) { create(:user, :admin) }
      let!(:questions_ge) { create_list(:question, 14, :dep_g, user: user) }
      let!(:answers_ge) { build_list(:answer, 14, :valid) do |answer, index|
                            answer.question = questions_ge[index]
                            answer.save!
                          end
                      }
      let!(:questions_spe) { create_list(:question, 10, :dep_f, user: user) }
      let!(:answers_spe) { build_list(:answer, 10, :valid) do |answer, index|
                              answer.question = questions_spe[index]
                              answer.save!
                            end
                          }
    before do
      sign_in user
    end

    it 'shows a qcm with 12 general questions and 8 specific questions' do
      visit('/qcm?category=fleuret&level=départemental')
      expect(page).to have_content("Qcm départemental spécifique fleuret")
      # verify that there is 12 general questions
      data_ge = find('div.qcm-general-questions[data-questions-gen]')
      within data_ge do
        expect(all('form').count).to eq(12) # find all matching elements and count them
      end
      # verify that there is 8 specific questions
      data_spe = find('div.qcm-specific-questions[data-questions-spe]')
      within data_spe do
        expect(all('form').count).to eq(8)
      end
    end
  end

  context "with level regional" do
      let(:user) { create(:user, :admin) }
      let!(:questions_ge) { create_list(:question, 22, :reg_g, user: user) }
      let!(:answers_ge) { build_list(:answer, 22, :valid) do |answer, index|
                            answer.question = questions_ge[index]
                            answer.save!
                          end
                      }
      let!(:questions_spe) { create_list(:question, 12, :reg_f, user: user) }
      let!(:answers_spe) { build_list(:answer, 12, :valid) do |answer, index|
                              answer.question = questions_spe[index]
                              answer.save!
                            end
                          }
    before do
      sign_in user
    end

    it 'shows a qcm with 20 general questions and 10 specific questions' do
      visit('/qcm?category=fleuret&level=régional')
      expect(page).to have_content("Qcm régional spécifique fleuret")
      # verify that there is 20 general questions
      data_ge = find('div.qcm-general-questions[data-questions-gen]')
      within data_ge do
        expect(all('form').count).to eq(20) # find all matching elements and count them
      end
      # verify that there is 10 specific questions
      data_spe = find('div.qcm-specific-questions[data-questions-spe]')
      within data_spe do
        expect(all('form').count).to eq(10)
      end
    end
  end

  context "answer" do
    let(:user) { create(:user, :admin) }
    let!(:question_ge) { create(:question, :dep_g, user: user) }
    let!(:answers_ge) { create(:answer, :valid, question: question_ge ) } # good_prop is answer one

    before do
      sign_in user
    end

    context "when valid answer" do
      it "shows the good answer in green and gives explanation" do
        visit('/qcm?category=fleuret&level=départemental')
        data_ge = find('div.qcm-general-questions[data-questions-gen]')
        within data_ge do
          find('input[value=un]').click # click on good answer
        end
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 1 bonne(s) réponse(s) sur 20 questions")
        click_link_or_button "Voir la correction du QCM"
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
        visit('/qcm?category=fleuret&level=départemental')
        data_ge = find('div.qcm-general-questions[data-questions-gen]')
        within data_ge do
          find('input[value=deux]').click # click on wrong answer
        end
        click_link_or_button "Valider les réponses"
        expect(page).to have_content("Vous avez 0 bonne(s) réponse(s) sur 20 questions")
        click_link_or_button "Voir la correction du QCM"
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
end
