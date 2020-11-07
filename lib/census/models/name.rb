class Name
  attr_reader :name, :rate, :ranking

  def initialize(name:, rate:, ranking:)
    @name = name
    @rate = rate
    @ranking = ranking
  end

  def self.general_ranking_by_locale(locale_id)
    fetch_ranking_by_locale(locale_id)
  end

  def self.male_ranking_by_locale(locale_id)
    fetch_ranking_by_locale(locale_id, 'M')
  end

  def self.female_ranking_by_locale(locale_id)
    fetch_ranking_by_locale(locale_id, 'F')
  end

  private_class_method def self.fetch_ranking_by_locale(locale_id, gender = nil)
    gender_param = gender ? "&sexo=#{gender}" : ''
    response = Faraday.get "#{NAMES_URL}/ranking?localidade=#{locale_id}#{gender_param}"
    return [] unless response.status == 200 && !response.body.empty?

    names = JSON.parse(response.body, symbolize_names: true)
    names[0][:res].map do |name|
      new(name: name[:nome], rate: name[:frequencia], ranking: name[:ranking])
    end
  end
end
