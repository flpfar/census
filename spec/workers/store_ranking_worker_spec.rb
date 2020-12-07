require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe StoreRankingWorker do
  it 'pushes a job on queue' do
    expect do
      StoreRankingWorker.perform_async(102)
    end.to change(StoreRankingWorker.jobs, :size).by(1)
  end

  it 'fetches a city ranking and saves in db' do
    json_content = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_ranking.json'))
    faraday_response = double('ranking', status: 200, body: json_content)
    allow(Faraday).to receive(:get).with("#{Census.config.names_url}/ranking?localidade=35")
                                   .and_return(faraday_response)

    StoreRankingWorker.new.perform(35)

    expect(RankingRepository.find_by_locale(35).ranked_names.size).to eq(4)
  end
end
