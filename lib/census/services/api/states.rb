class StatesAPI
  def self.fetch_states
    response = Faraday.get "#{LOCALES_URL}/estados"
    return [] unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end
end
