# frozen_string_literal = true

# controller for admin lexicons
module Admin
  class LexiconResultsController < ApplicationController

    def index
      @results = LexiconResult.all
      @users = User.where(role: "intern")
      authorize([:admin, :lexicon_result])
    end
  end
end
