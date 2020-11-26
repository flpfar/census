describe RankingRepository do
  describe '.save' do
    it 'sucessfully' do
      ranking = []
      ranking << RankedName.new(locale_id: 1, name: 'Lorem', rate: 35, ranking: 10, gender: 'M')
      ranking << RankedName.new(locale_id: 1, name: 'Ipsum', rate: 31, ranking: 11, gender: 'M')

      RankingRepository.save(ranking)

      expect(RankingRepository.find_by_locale(1).ranked_names.size).to eq(2)
    end

    it 'returns nil if argument is empty' do
      ranking = []

      result = RankingRepository.save(ranking)

      expect(result).to be_nil
    end
  end

  describe '.find_by_locale' do
    it 'returns a Ranking object' do
      ranking = []
      ranking << RankedName.new(locale_id: 1, name: 'Lorem', rate: 35, ranking: 10)
      ranking << RankedName.new(locale_id: 2, name: 'Ipsum', rate: 32, ranking: 8)
      ranking << RankedName.new(locale_id: 1, name: 'Dolor', rate: 31, ranking: 11)
      RankingRepository.save(ranking)

      result = RankingRepository.find_by_locale(1)

      expect(result).to be_an_instance_of(Ranking)
      expect(result.ranked_names.size).to eq(2)
      expect(result.ranked_names.first).to be_an_instance_of(RankedName)
    end

    it 'filters by gender if parameter is passed' do
      ranking = []
      ranking << RankedName.new(locale_id: 1, name: 'Lorem', rate: 35, ranking: 10, gender: 'M')
      ranking << RankedName.new(locale_id: 1, name: 'Ipsum', rate: 32, ranking: 8, gender: 'F')
      ranking << RankedName.new(locale_id: 1, name: 'Dolor', rate: 31, ranking: 11, gender: 'M')
      RankingRepository.save(ranking)

      result = RankingRepository.find_by_locale(1, gender: 'F')

      expect(result.ranked_names.size).to eq(1)
      expect(result.ranked_names.first.name).to eq('Ipsum')
    end
  end
end
