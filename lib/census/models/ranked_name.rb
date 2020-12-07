class RankedName
  attr_reader :locale_id, :name, :rate, :ranking, :id, :gender

  def initialize(locale_id:, name:, rate:, ranking:, gender: nil)
    @locale_id = locale_id.to_i
    @name = name
    @rate = rate.to_i
    @ranking = ranking.to_i
    @gender = gender
  end
end
