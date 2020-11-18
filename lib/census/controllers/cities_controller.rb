require_relative '../models/city'
require_relative '../models/name'
require_relative '../views/cities'
require_relative '../views/names'

class CitiesController
  def self.index
    CitiesView.index
  end

  def self.show(city_name)
    locale_id = City.find_id_by_name(city_name)
    return CitiesView.city_name_not_found unless locale_id

    general_ranking = Name.general_ranking_by_locale(locale_id)
    male_ranking = Name.male_ranking_by_locale(locale_id)
    female_ranking = Name.female_ranking_by_locale(locale_id)
    NamesView.rankings_by_locale(general_ranking, male_ranking, female_ranking)
  end
end
