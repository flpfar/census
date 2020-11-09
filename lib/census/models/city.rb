class City
  attr_reader :name, :id

  def initialize(name:, id:)
    @name = name
    @id = id
  end

  def self.all
    response = Faraday.get "#{LOCALES_URL}/municipios"
    return [] unless response.status == 200

    cities = JSON.parse(response.body, symbolize_names: true)
    cities.map do |city|
      new(id: city[:id], name: city[:nome].downcase)
    end
  end

  def self.find_id_by_name(city_name)
    city = all.find { |item| item.name == city_name }

    return city.id if city
  end
end
