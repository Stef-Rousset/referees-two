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
    lexicon_rules = Lexicon.filter_by_category(:rules).shuffle
    lexicon_actions = Lexicon.filter_by_category(:actions).shuffle
    lexicon_prep = Lexicon.filter_by_category(:prep_hab).shuffle
    lexicon_other = Lexicon.filter_by_category(:other).shuffle
    @lexicons = lexicon_rules.first(2) + lexicon_actions.first(8) + lexicon_prep.first(7) + lexicon_other.first(3)
    authorize Lexicon
  end
end
