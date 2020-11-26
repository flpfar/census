class RankingsController
  def self.ranking_by_locale(locale_id)
    general_ranking = Ranking.from_locale(locale_id).ranked_names
    male_ranking = Ranking.from_locale(locale_id, gender: 'M').ranked_names
    female_ranking = Ranking.from_locale(locale_id, gender: 'F').ranked_names
    NamesView.rankings_by_locale(general_ranking, male_ranking, female_ranking)
  end
end
