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
    cities_from_db = CityRepository.all
    return cities_from_db unless cities_from_db.empty?

    cities_json = CitiesApi.new.fetch_data
    cities = parse_json(cities_json)
    CityRepository.save_batch(cities)
    CityRepository.all
  end

  def self.find_id_by_name(city_name)
    all if CityRepository.all.empty?

    city_name = CityNameFormatter.format(city_name)
    city = CityRepository.find_by_name(city_name)

    return city.id if city
  end

  def self.parse_json(cities)
    cities.map do |city|
      new(id: city[:id], name: city[:nome], state_id: city[:microrregiao][:mesorregiao][:UF][:id])
    end
  end
end
