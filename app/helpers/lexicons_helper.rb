module LexiconsHelper

  def month_beginning
    DateTime.now.day >= 1 && DateTime.now.day < 16 ? true : false
  end

  def l_category(lexicon)
    case lexicon.category
    when "basics"
      "Bases de l'escrime"
    when "actions"
      "Actions"
    when "prep"
      "Préparations"
    when "other"
      "Compétition, règlement, arbitrage"
    end
  end
end
