class StoreRankingWorker
  include Sidekiq::Worker

  def perform(locale_id, gender = nil)
    ranking = fetch_ranking(locale_id, gender)
    save_to_db(ranking) unless ranking.nil?
  end

  private

  def fetch_ranking(locale_id, gender)
    Ranking.from_locale(locale_id, gender: gender)
  end

  def save_to_db(ranking)
    RankingRepository.save(ranking.ranked_names)
  end
end
