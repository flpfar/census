require_relative '../../lib/census/models/city'

describe City do
  describe '.all' do
    it 'should return an array of Cities' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_cities.json'))
      faraday_response = double('cities', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{LOCALES_URL}/municipios").and_return(faraday_response)

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

      allow(Faraday).to receive(:get).with("#{LOCALES_URL}/municipios").and_return(faraday_response)

      result = City.find_id_by_name('cabixi')

      expect(result).to eq(1100031)
    end
  end
end
