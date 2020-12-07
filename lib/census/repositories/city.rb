class CityRepository
  def self.save(city)
    con = DBConnection.new
    con.exec('INSERT INTO cities (id, name, state_id)'\
              "VALUES (#{city.id}, '#{city.name}', '#{city.state_id}')"\
              'ON CONFLICT DO NOTHING;')
  end

  def self.save_batch(cities)
    con = DBConnection.new

    query_values = cities.map do |city|
      "(#{city.id}, '#{city.name}', '#{city.state_id}')"
    end.join(',')

    query = "INSERT INTO cities (id, name, state_id) VALUES #{query_values};"
    con.exec(query)
  end

  def self.all
    con = DBConnection.new
    cities = con.exec('SELECT * FROM cities;')

    cities.map do |city|
      City.new(id: city['id'], name: city['name'], state_id: city['state_id'])
    end
  end

  def self.count
    con = DBConnection.new
    con.exec('SELECT count(*) FROM cities;').first['count'].to_i
  end

  def self.find_by_name(name)
    con = DBConnection.new
    city = con.exec("SELECT * FROM cities WHERE name ILIKE '#{name}' LIMIT 1").first
    return nil unless city

    City.new(id: city['id'], name: city['name'], state_id: city['state_id'])
  end

  def self.find_by_state(id)
    con = DBConnection.new
    cities = con.exec("SELECT * FROM cities WHERE state_id = #{id};")

    cities.map do |city|
      City.new(id: city['id'], name: city['name'], state_id: city['state_id'])
    end
  end
end
