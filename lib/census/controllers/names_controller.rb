require_relative '../models/name'
require_relative '../models/name_by_decade'
require_relative '../views/names'

class NamesController
  def self.ranking_by_locale(locale_id)
    general_ranking = Name.general_ranking_by_locale(locale_id)
    male_ranking = Name.male_ranking_by_locale(locale_id)
    female_ranking = Name.female_ranking_by_locale(locale_id)
    NamesView.rankings_by_locale(general_ranking, male_ranking, female_ranking)
  end

  def self.index
    NamesView.index
  end

  def self.search_names(names_string)
    result = NameByDecade.fetch_names(names_string)
    NamesView.names_by_decades(result)
  end
end
