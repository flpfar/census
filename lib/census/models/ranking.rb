class Ranking
  attr_reader :locale_id, :ranked_names, :gender

  def initialize(locale_id:, ranked_names: nil, gender: nil)
    @locale_id = locale_id.to_i
    @ranked_names = ranked_names
    @gender = gender
  end

  def self.from_locale(locale_id, gender: nil)
    api_result = RankingsApi.new(locale_id: locale_id, gender: gender).fetch_data

    return nil if api_result.nil? || api_result.empty?

    parse_response(api_result)
  end

  def self.parse_response(response)
    ranked_names = response[:res].map do |name|
      RankedName.new(locale_id: response[:localidade], name: name[:nome], rate: name[:frequencia],
                     ranking: name[:ranking], gender: response[:gender])
    end

    Ranking.new(ranked_names: ranked_names, locale_id: response[:localidade], gender: response[:gender])
  end

  private_class_method :parse_response
end
