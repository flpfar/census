require_relative '../../lib/census/models/state'

describe State do
  describe '.all' do
    it 'should return an array of states' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_states.json'))
      faraday_response = double('states', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{Census.config.locales_url}/estados").and_return(faraday_response)

      result = State.all

      expect(result).to be_an_instance_of(Array)
      expect(result.first).to be_an_instance_of(State)
    end
  end

  describe '.find' do
    context 'when found' do
      it 'should return a state' do
        state = State.new(name: 'Acre', initials: 'AC', id: 12)
        state.save

        result = State.find('AC')

        expect(result).to be_an_instance_of(State)
        expect(result.id).to eq(12)
        expect(result.initials).to eq(state.initials)
        expect(result.name).to eq(state.name)
      end
    end

    context 'when not found' do
      it 'should return nil' do
        json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_states.json'))
        faraday_response = double('states', status: 200, body: json_content)

        allow(Faraday).to receive(:get).with("#{Census.config.locales_url}/estados").and_return(faraday_response)

        result = State.find('AA')

        expect(result).to be_nil
      end
    end
  end

  describe '#cities' do
    it 'should return an array of cities from that state' do
      state = State.new(name: 'Acre', initials: 'AC', id: 12).save
      City.new(id: 11, name: 'Cidade1', state_id: 12).save
      City.new(id: 22, name: 'Cidade2', state_id: 20).save
      City.new(id: 33, name: 'Cidade3', state_id: 12).save

      result = state.cities

      expect(result).to be_an_instance_of(Array)
      expect(result.first).to be_an_instance_of(City)
      expect(result.size).to eq(2)
    end
  end
end
