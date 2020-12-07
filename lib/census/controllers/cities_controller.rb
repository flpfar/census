class CitiesController
  def self.index
    CitiesView.index
  end

  def self.show(city_name)
    locale_id = City.find_id_by_name(city_name)
    return CitiesView.city_name_not_found unless locale_id

    locale_ranking = LocaleRanking.new(locale_id)
    puts Views::Rankings.by_locale(locale_ranking)
  end
end
