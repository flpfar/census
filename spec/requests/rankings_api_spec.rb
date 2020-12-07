describe RankingsApi do
  describe '#fetch_data' do
    it 'should return a hash with a ranking from a place' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_ranking.json'))
      faraday_response = double('ranking', status: 200, body: json_content)
      allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35")
                                     .and_return(faraday_response)

      result = RankingsApi.new(locale_id: 35).fetch_data

      expect(result).to be_an_instance_of(Hash)
      expect(result[:localidade]).to eq('35')
      expect(result[:res]).to be_an_instance_of(Array)
      expect(result[:gender]).to be_nil
      expect(result[:res][0][:nome]).to eq('MARIA')
    end

    it 'should return a hash with a ranking from a place and gender' do
      json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_ranking_with_gender.json'))
      faraday_response = double('ranking', status: 200, body: json_content)
      allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35&sexo=F")
                                     .and_return(faraday_response)

      result = RankingsApi.new(locale_id: 35, gender: 'F').fetch_data

      expect(result).to be_an_instance_of(Hash)
      expect(result[:localidade]).to eq('35')
      expect(result[:res]).to be_an_instance_of(Array)
      expect(result[:sexo]).to eq('F')
    end

    it 'should return an empty array if request fails' do
      faraday_response = double('ranking', status: 500)
      allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35")
                                     .and_return(faraday_response)

      result = RankingsApi.new(locale_id: 35).fetch_data

      expect(result).to eq([])
    end
  end
end
