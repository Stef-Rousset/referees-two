class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.contributor? || user.admin?
  end

  def show?
    user.contributor? || user.admin?
  end

  def create?
    user.contributor? || user.admin?
  end

  def edit?
    record.user == user || user.admin?
  end

  def update?
    record.user == user || user.admin?
  end

  def destroy?
    record.user == user || user.admin?
  end

  def qcm?
    true
  end

  def missed_questions?
    user
  end

  def add_failed_question?
    user
  end

  def destroy_failed_question?
    user
  end

  def add_failed_questions?
    user
  end

  def destroy_failed_questions?
    user
  end
end
