class LexiconPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def month_beginning
    DateTime.now.day >= 1 && DateTime.now.day < 16 ? true : false
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
    user && (month_beginning && user.intern? || user.admin?)
  end
end
