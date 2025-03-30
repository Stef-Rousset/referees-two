class LexiconPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def lexicon_qcm?
    true
  end
end
