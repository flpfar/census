class NamesApi
  def initialize(names)
    @names = names
  end

  def fetch_data
    response = Faraday.get "#{Census.config.names_url}/#{params}"

    return [] unless response.status == 200

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :names

  def params
    CGI.escape(names.join('|'))
  end
end
