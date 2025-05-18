# frozen_string_literal = true

# controller for admin lexicons
module Admin
  class LexiconsResultsController < ApplicationController

    def index
      @results = LexiconsResult.all
      @users = User.where(role: "intern")
      authorize([:admin, :lexicons_result])
    end
  end
end
