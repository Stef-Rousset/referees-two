# frozen_string_literal = true

require 'will_paginate/array' #needed to work with arrays

class LexiconsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @lexicons = policy_scope(Lexicon)
    @count = @lexicons.length
    @lexicons = @lexicons.paginate(page: params[:page], per_page: 1)
  end

  def qcm
    lexicons = Lexicon.includes(:lexicon_answer)
    lexicon_basics = lexicons.filter_by_category(:basics).shuffle
    lexicon_actions = lexicons.filter_by_category(:actions).shuffle
    lexicon_prep = lexicons.filter_by_category(:prep).shuffle
    lexicon_other = lexicons.filter_by_category(:other).shuffle
    @lexicons = lexicon_basics.first(5) + lexicon_actions.first(8) + lexicon_prep.first(4) + lexicon_other.first(3)
    authorize Lexicon
  end

  def add_lexicon_result
    authorize Lexicon

    return unless params[:score]

    current_user.lexicons_results.create!(score: params[:score])
    head :ok
  end
end
