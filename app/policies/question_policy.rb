class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
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

  def dashboard?
    user.contributor? || user.admin?
  end
end
