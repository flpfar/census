class RankingsApi
  def initialize(locale_id:, gender: nil)
    @locale_id = locale_id
    @gender = gender
  end

  def fetch_data
    response = Faraday.get "#{Census.config.names_url}/ranking#{process_params}" do |req|
      req.options.timeout = 5
    end
    return [] unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)[0]
  end

  private

  attr_reader :locale_id, :gender

  def process_params
    "?localidade=#{locale_id}#{gender ? "&sexo=#{gender}" : ''}"
  end
end
