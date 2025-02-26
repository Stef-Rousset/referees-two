# frozen_string_literal = true

require 'will_paginate/array' #needed to work with arrays

# controller for questions
class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :qcm]
  before_action :set_question, only: [:show, :edit, :update, :destroy, :add_failed_question, :destroy_failed_question]

  def index
    @questions = policy_scope(Question).order(created_at: :desc)
    @questions = @questions.filter_by_level(params[:level]) if params[:level].present?
    @questions = @questions.filter_by_category(params[:category]) if params[:category].present?
    @count = @questions.length
    @questions = @questions.paginate(page: params[:page], per_page: 1)
  end

  def qcm
    @level = params[:level]
    @category = params[:category]
    @questions = Question.all
    authorize @questions
    @questions_generales = @questions.filter_by_level(@level).where(category: 1).shuffle if @level.present?
    @questions_specifiques = @questions.filter_by_level(@level).filter_by_category(@category).shuffle if @level.present? && @category.present?
    if @level == 'départemental'
      @questions_generales = @questions_generales.first(12)
      @questions_specifiques = @questions_specifiques.first(8)
    else
      @questions_generales = @questions_generales.first(20)
      @questions_specifiques = @questions_specifiques.first(10)
    end
  end

  def missed_questions
    @missed_questions = Question.joins(:failed_questions).where(missed_questions: { user_id: current_user.id })
    @count = @missed_questions.length
    authorize @missed_questions
  end

  def add_failed_question
    return unless @question

    current_user.failed_questions << @question if !current_user.failed_questions.include?(@question)
    head :ok # Returns a response that has no content, with status ok
  end

  def destroy_failed_question
    return unless @question

    current_user.failed_questions.destroy(@question) if current_user.failed_questions.include?(@question)
    head :ok
  end

  def add_failed_questions
    authorize Question
    return unless params[:ids]

    ids = params[:ids].split(',').map(&:to_i)
    # ids est un array avec ttes les mauvaises réponses au qcm
    if ids.present?
      # on enlève les ids qui figurent déjà dans les mauvaises réponses
      # et on ajoute les ids restants à la table de jointure
      Question.where(id: ids)
              .reject { |question| current_user.failed_questions.include?(question) }
              .map { |question| current_user.failed_questions << question }
    end
    head :ok
  end

  def destroy_failed_questions
    authorize Question
    return unless params[:ids]

    # ids est un array avec ttes les bonnes réponses au qcm
    ids = params[:ids].split(',').map(&:to_i)
    if ids.present?
      # on select les ids qui figurent dans la table de jointure
      # et on les enlève de la table
      Question.where(id: ids)
              .select { |question| current_user.failed_questions.include?(question) }
              .map { |question| current_user.failed_questions.destroy(question) }
    end
    head :ok
  end

  def show
  end

  def new
    @user = current_user
    @question = Question.new
    # build associated answer to get it in the form
    @question.build_answer
    @question.user = @user
    authorize @question
  end

  def create
    @user = current_user
    @question = Question.new(question_params)
    @question.user = @user
    authorize @question
    if @question.save
      redirect_to question_path(@question)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @answer = @question.answer
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path
  end

  def dashboard
    current_user.contributor? ? @questions = Question.where(user_id: current_user) : @questions = Question.all
    @questions_dep_g = @questions.dep_g
    @questions_dep_f = @questions.dep_f
    @questions_dep_e = @questions.dep_e
    @questions_dep_s = @questions.dep_s
    @questions_reg_g = @questions.reg_g
    @questions_reg_f = @questions.reg_f
    @questions_reg_e = @questions.reg_e
    @questions_reg_s = @questions.reg_s
    authorize @questions
  end

  private

  def set_question
    @question = Question.find(params[:id])
    authorize @question
  end

  def question_params
    params.require(:question).permit(:statement, :prop_one, :prop_two, :prop_three, :level, :category, answer_attributes: [:id, :explanation, :good_prop, :_destroy])
  end
end

