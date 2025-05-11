# frozen_string_literal = true

# controller for admin lexicons
module Admin
  class LexiconsController < ApplicationController
    before_action :set_lexicon, only: [:show, :edit, :update, :destroy]

    def index
      @lexicons = Lexicon.all
      @lexicons_rules = @lexicons.rules
      @lexicons_actions = @lexicons.actions
      @lexicons_prep = @lexicons.prep_hab
      @lexicons_other = @lexicons.other
      authorize([:admin, :lexicon])
    end

    def show
    end

    def new
      @lexicon = Lexicon.new
      # build associated answer to get it in the form
      @lexicon.build_lexicon_answer
      authorize @lexicon
    end

    def create
      @lexicon = Lexicon.new(lexicon_params)
      authorize @lexicon
      if @lexicon.save
        redirect_to admin_lexicon_path(@lexicon)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @answer = @lexicon.lexicon_answer
    end

    def update
      if @lexicon.update(lexicon_params)
        redirect_to admin_lexicon_path(@lexicon)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lexicon.destroy
      redirect_to admin_lexicons_path
    end

    private

    def set_lexicon
      @lexicon = Lexicon.find(params[:id])
      authorize @lexicon
    end

    def lexicon_params
      params.require(:lexicon).permit(:statement, :prop_one, :prop_two, :prop_three, :category, lexicon_answer_attributes: [:id, :good_prop, :_destroy])
    end
  end
end
