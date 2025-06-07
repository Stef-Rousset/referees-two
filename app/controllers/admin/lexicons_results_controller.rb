# frozen_string_literal = true

# controller for admin lexicons
module Admin
  class LexiconsResultsController < ApplicationController

    def index
      @results = LexiconsResult.all
      @users = User.where(role: "intern")
      authorize([:admin, :lexicons_result])
      respond_to do |format|
        format.html
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename = "Résultats_lexique_2025_2026.xlsx"'
        }
      end
    end
  end
end
