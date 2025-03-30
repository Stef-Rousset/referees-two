# frozen_string_literal = true

# controller for admin questions
module Admin
  class QuestionsController < ApplicationController
    before_action :set_question, only: [:show, :edit, :update, :destroy]

    def index
      current_user.contributor? ? @questions = Question.where(user_id: current_user) : @questions = Question.all
      @questions_dep_g = @questions.dep_g
      @questions_dep_f = @questions.dep_f
      @questions_dep_e = @questions.dep_e
      @questions_dep_s = @questions.dep_s
      @questions_reg_g = @questions.reg_g
      @questions_reg_f = @questions.reg_f
      @questions_reg_e = @questions.reg_e
      @questions_reg_s = @questions.reg_s
      authorize([:admin, :question])
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
        redirect_to admin_question_path(@question)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @answer = @question.answer
    end

    def update
      if @question.update(question_params)
        redirect_to admin_question_path(@question)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @question.destroy
      redirect_to admin_questions_path
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
end
