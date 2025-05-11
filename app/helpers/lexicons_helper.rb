module LexiconsHelper

  def month_beginning
    DateTime.now.day >= 1 && DateTime.now.day < 16 ? true : false
  end

  def l_category(lexicon)
    case lexicon.category
    when "rules"
      "Règles"
    when "actions"
      "Actions"
    when "prep_hab"
      "Préparations et habiletés"
    when "other"
      "Autre"
    end
  end
end
