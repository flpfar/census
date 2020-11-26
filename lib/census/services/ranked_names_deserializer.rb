class RankedNamesDeserializer
  def initialize(ranking)
    @ranking = ranking
  end

  def call
    ranking.map do |item|
      RankedName.new(locale_id: item['locale_id'], name: item['name'], rate: item['rate'],
                     ranking: item['ranking'], gender: item['gender'])
    end
  end

  private

  attr_reader :ranking
end
