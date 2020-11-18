require_relative '../../lib/census/repositories/city'
require_relative '../../lib/census/models/city'

# rubocop:disable Style/NumericLiterals
describe CityRepository do
  describe '.save' do
    it 'successfully' do
      city = City.new(id: 123456, name: 'São Paulo', state_id: 35)

      CityRepository.save(city)

      expect(City.all.first.id).to eq(123456)
    end
  end

  describe '.save_batch' do
    it 'successfully' do
      cities = []
      cities << City.new(id: 111111, name: 'Cidade1', state_id: 12)
      cities << City.new(id: 222222, name: 'Cidade2', state_id: 20)

      CityRepository.save_batch(cities)

      expect(CityRepository.all.last.name).to eq('cidade2')
      expect(CityRepository.all.last.id).to eq(222222)
    end
  end

  describe '.find_by_name' do
    it 'should return a city when found' do
      city = City.new(id: 123456, name: 'São Paulo', state_id: 35)
      city.save

      result = CityRepository.find_by_name('São Paulo')

      expect(result.id).to eq(city.id)
      expect(result.state_id).to eq(city.state_id)
    end
  end

  describe '.all' do
    it 'returns an array of cities' do
      City.new(id: 111111, name: 'Cidade1', state_id: 12).save
      City.new(id: 222222, name: 'Cidade2', state_id: 20).save
      City.new(id: 333333, name: 'Cidade3', state_id: 21).save

      result = CityRepository.all

      expect(result).to be_an_instance_of(Array)
      expect(result.size).to eq(3)
      expect(result.first).to be_an_instance_of(City)
    end
  end
end
# rubocop:enable Style/NumericLiterals
