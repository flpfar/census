class City
  attr_reader :name, :id, :state_id

  def initialize(name:, id:, state_id:)
    @name = CityNameFormatter.format(name)
    @id = id.to_i
    @state_id = state_id.to_i
  end

  def save
    CityRepository.save(self)
  end

  def self.all
    load_cities
    CityRepository.all
  end

  def self.find_id_by_name(city_name)
    load_cities

    city_name = CityNameFormatter.format(city_name)
    city = CityRepository.find_by_name(city_name)

    return city.id if city
  end

  def self.find_by_state(state_id)
    load_cities

    CityRepository.find_by_state(state_id)
  end

  def self.parse_json(cities)
    cities.map do |city|
      new(id: city[:id], name: city[:nome], state_id: city[:microrregiao][:mesorregiao][:UF][:id])
    end
  end

  def self.load_cities
    return unless CityRepository.count.zero?

    cities_json = CitiesApi.new.fetch_data
    cities = parse_json(cities_json)
    CityRepository.save_batch(cities)
  end

  private_class_method :load_cities, :parse_json
end
