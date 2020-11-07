require_relative '../models/name'
require_relative '../views/names'

class NamesController
  def self.ranking_by_locale(locale_id)
    general_ranking = Name.general_ranking_by_locale(locale_id)
    male_ranking = Name.male_ranking_by_locale(locale_id)
    female_ranking = Name.female_ranking_by_locale(locale_id)
    NamesView.rankings_by_state(general_ranking, male_ranking, female_ranking)
  end
end
