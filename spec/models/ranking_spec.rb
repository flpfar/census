describe Ranking do
  describe '.from_locale' do
    it 'returns a Ranking with RankedNames' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_ranking.json'))
      faraday_response = double('ranking', status: 200, body: json_content)
      allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35")
                                     .and_return(faraday_response)

      result = Ranking.from_locale(35)

      expect(result).to be_an_instance_of(Ranking)
      expect(result.ranked_names).to be_an_instance_of(Array)
      expect(result.ranked_names.first.name).to eq('MARIA')
      expect(result.locale_id).to eq(35)
    end

    it 'returns new when request fails' do
      faraday_response = double('ranking', status: 500)
      allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35")
                                     .and_return(faraday_response)

      result = Ranking.from_locale(35)

      expect(result).to be_nil
    end
  end
end
