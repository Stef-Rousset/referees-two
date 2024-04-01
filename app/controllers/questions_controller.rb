#require 'will_paginate/array' #needed to work with arrays

class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :qcm]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

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
    @questions = policy_scope(Question)
    @questions_generales = @questions.filter_by_level(params[:level]).where(category: 1).shuffle if @level.present?
    @questions_specifiques = @questions.filter_by_level(params[:level]).filter_by_category(params[:category]).shuffle if @level.present? && @category.present?
    if @level == 'départemental'
      @questions_generales = @questions_generales.first(12)
      @questions_specifiques = @questions_specifiques.first(8)
    else
      @questions_generales = @questions_generales.first(20)
      @questions_specifiques = @questions_specifiques.first(10)
    end
  end

  def show
  end

  def new
    @user = current_user
    @question = Question.new
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
      render :new
    end
  end

  def edit
    @answer = @question.answer
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
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
    params.require(:question).permit(:statement, :prop_one, :prop_two, :prop_three, :level, :category)
  end
end

