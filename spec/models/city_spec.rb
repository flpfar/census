require_relative '../../lib/census/models/city'

describe City do
  describe '.all' do
    it 'should return an array of Cities' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_cities.json'))
      faraday_response = double('cities', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{Census.config.locales_url}/municipios").and_return(faraday_response)

      result = City.all

      expect(result).to be_an_instance_of(Array)
      expect(result.size).to eq(3)
      expect(result.first).to be_an_instance_of(City)
    end
  end

  describe '.find_id_by_name' do
    it 'should return the city id' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_cities.json'))
      faraday_response = double('cities', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{Census.config.locales_url}/municipios").and_return(faraday_response)

      result = City.find_id_by_name('cabixi')

      expect(result).to eq(1100031) # rubocop:disable Style/NumericLiterals
    end
  end

  describe '.find_by_state' do
    it 'should return an array of cities from a state' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_cities.json'))
      faraday_response = double('cities', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{Census.config.locales_url}/municipios").and_return(faraday_response)

      result = City.find_by_state(11)

      expect(result).to be_an_instance_of(Array)
      expect(result.first).to be_an_instance_of(City)
      expect(result.size).to eq(3)
    end

    it 'should not fetch from api if db is not empty' do
      City.new(id: 11, name: 'Cidade1', state_id: 12).save
      City.new(id: 22, name: 'Cidade2', state_id: 20).save
      City.new(id: 33, name: 'Cidade3', state_id: 12).save

      result = City.find_by_state(12)

      expect(result).to be_an_instance_of(Array)
      expect(result.first).to be_an_instance_of(City)
      expect(result.size).to eq(2)
    end

    it 'should return an empty array if no cities are found in the state' do
      City.new(id: 11, name: 'Cidade1', state_id: 12).save
      City.new(id: 22, name: 'Cidade2', state_id: 20).save
      City.new(id: 33, name: 'Cidade3', state_id: 12).save

      result = City.find_by_state(1)

      expect(result).to be_an_instance_of(Array)
      expect(result.empty?).to be_truthy
    end
  end
end
