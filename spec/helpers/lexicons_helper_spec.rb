require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the LexiconsHelper. For example:
#
# describe LexiconsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe LexiconsHelper, type: :helper do
  let(:rules) { create(:lexicon, :rules) }
  let(:prep_hab) { create(:lexicon, :prep_hab) }
  let(:other) { create(:lexicon, :other) }
  let(:actions) { create(:lexicon, :valid)}

  it "month_beginning should return true or false depending on date" do
    if DateTime.now.day >= 1 && DateTime.now.day < 16
      expect(month_beginning).to be(true)
    else
      expect(month_beginning).to be(false)
    end
  end

  it "l_category should return the right category as string" do
    expect(l_category(rules)).to eq("Règles")
    expect(l_category(prep_hab)).to eq("Préparations et habiletés")
    expect(l_category(other)).to eq("Autre")
    expect(l_category(actions)).to eq("Actions")
  end
end
