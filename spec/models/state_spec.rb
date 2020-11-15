require_relative '../../lib/census/models/state'

describe State do
  describe '.all' do
    it 'should return an array of states' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_states.json'))
      faraday_response = double('states', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{LOCALES_URL}/estados").and_return(faraday_response)

      result = State.all

      expect(result).to be_an_instance_of(Array)
      expect(result.size).to eq(5)
      expect(result.first).to be_an_instance_of(State)
    end
  end

  describe '.find' do
    context 'when found' do
      it 'should return a state' do
        json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_states.json'))
        faraday_response = double('states', status: 200, body: json_content)

        allow(Faraday).to receive(:get).with("#{LOCALES_URL}/estados").and_return(faraday_response)

        result = State.find('AC')

        expect(result).to be_an_instance_of(State)
        expect(result.id).to eq(12)
        expect(result.initials).to eq('AC')
        expect(result.name).to eq('Acre')
      end
    end

    context 'when not found' do
      it 'should return nil' do
        json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_states.json'))
        faraday_response = double('states', status: 200, body: json_content)

        allow(Faraday).to receive(:get).with("#{LOCALES_URL}/estados").and_return(faraday_response)

        result = State.find('AA')

        expect(result).to be_nil
      end
    end
  end
end
