class LexiconPolicy < ApplicationPolicy
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
    user.contributor? || user.admin?
  end

  def update?
    user.contributor? || user.admin?
  end

  def destroy?
    user.contributor? || user.admin?
  end

  def qcm?
    true
  end
end
