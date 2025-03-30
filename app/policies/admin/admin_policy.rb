module Admin
  class AdminPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end

    def index?
      user.contributor? || user.admin?
    end
  end
end
