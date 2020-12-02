class LocaleRanking
  def initialize(locale_id)
    @locale_id = locale_id
  end

  def general
    Ranking.from_locale(locale_id).ranked_names
  end

  def male
    Ranking.from_locale(locale_id, gender: 'M').ranked_names
  end

  def female
    Ranking.from_locale(locale_id, gender: 'F').ranked_names
  end

  private

  attr_reader :locale_id
end
