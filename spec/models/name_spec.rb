require_relative '../../lib/census/models/name'
require_relative '../../lib/census/utils/api'

describe Name do
  describe '.general_ranking_by_locale' do
    context 'with valid locale id' do
      it 'should return an array of names' do
        json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_ranking.json'))
        faraday_response = double('ranking', status: 200, body: json_content)

        allow(Faraday).to receive(:get).with("#{NAMES_URL}/ranking?localidade=35").and_return(faraday_response)

        result = Name.general_ranking_by_locale(35)

        expect(result).to be_an_instance_of(Array)
        expect(result.size).to eq(4)
        expect(result.first).to be_an_instance_of(Name)
      end
    end

    context 'with invalid locale id' do
      it 'should return an empty array' do
        faraday_response = double('ranking', status: 200, body: [])

        allow(Faraday).to receive(:get).with("#{NAMES_URL}/ranking?localidade=123456").and_return(faraday_response)

        result = Name.general_ranking_by_locale(123_456)

        expect(result).to be_an_instance_of(Array)
        expect(result.size).to eq(0)
      end
    end
  end
end
