require 'rails_helper'

RSpec.describe "Qcm", type: :system do

  context "on qcm page" do
      let(:user) { create(:user, :admin) }
      let!(:questions_ge) { create_list(:question, 12, :dep_g, user: user) }
      let!(:answers_ge) { build_list(:answer, 12, :valid) do |answer, index|
                            answer.question = questions_ge[index]
                            answer.save!
                          end
                      }
      let!(:questions_spe) { create_list(:question, 8, :dep_f, user: user) }
      let!(:answers_spe) { build_list(:answer, 8, :valid) do |answer, index|
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
end
