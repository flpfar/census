class LocalesApi
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def fetch_data
    response = Faraday.get "#{LOCALES_URL}/#{type}"
    return [] unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end
end
