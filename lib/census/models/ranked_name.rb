class RankedName
  attr_reader :locale_id, :name, :rate, :ranking, :id, :gender

  def initialize(locale_id:, name:, rate:, ranking:, id: nil, gender: nil) # rubocop:disable Metrics/ParameterLists
    @locale_id = locale_id.to_i
    @name = name
    @rate = rate.to_i
    @ranking = ranking.to_i
    @id = id
    @gender = gender
  end
end
