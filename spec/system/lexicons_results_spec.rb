require 'rails_helper'

RSpec.describe "Lexicons Results", type: :system do
  let(:admin) { create(:user, :admin)}
  let(:user) { create(:user, :intern) }
  let(:second_user) { create(:user, :intern) }
  let!(:lexicons_result_one) { create(:lexicons_result, :valid, user: user) }
  let!(:lexicons_result_two) { create(:lexicons_result, :created_one_month_ago, user: user) }
  let!(:lexicons_result_three) { create(:lexicons_result, :valid, user: second_user) }
  let!(:lexicons_result_four) { create(:lexicons_result, :created_one_month_ago, user: second_user) }

  before do
    sign_in admin
  end

  after do
    File.delete("/Users/stephanierousset/Downloads/Résultats_lexique_2025_2026.xlsx") if File.exist?("/Users/stephanierousset/Downloads/Résultats_lexique_2025_2026.xlsx")
  end

  it 'shows a table with 2 lines' do
    visit admin_lexicons_results_path
    trs = page.all('tr')
    expect(trs.count).to eq(3) # 1 tr pour les headers, et 2 tr pr les 2 users
    tds = page.all('td')
    eighteen_scores = 0
    fourteen_scores = 0
    tds.each do |td|
      eighteen_scores += 1 if td.text == "18"
      fourteen_scores += 1 if td.text == "14"
    end
    expect(eighteen_scores).to eq(2) # valid result score is 18
    expect(fourteen_scores).to eq(2) # created_one_month_ago result score is 14
  end

  it 'downloads a file when clicking on download file link' do
    # count the numbers of files in downloads
    path = "/Users/stephanierousset/Downloads/*"
    count = Dir[path].length

    visit admin_lexicons_results_path
    click_on "Télécharger les résultats au format excel"
    # no error after click on link
    expect(page).to have_content("Résultats des QCM de lexique")
    # check that one file has been downloaded
    expect(Dir[path].length).to eq(count + 1)
    # Dir[path] is an array of all the files paths included in downloads
    expect(Dir[path]).to include("/Users/stephanierousset/Downloads/Résultats_lexique_2025_2026.xlsx")
  end
end

