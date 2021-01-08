class NameByDecadeParser
  def initialize(names_hash)
    @names_hash = names_hash
  end

  def call
    parse_names_hash
  end

  private

  attr_reader :names_hash

  def parse_names_hash
    names_hash.map do |item|
      name = item[:nome].downcase
      decades = parse_decades_hash(item[:res])
      NameByDecade.new(name: name, decades: decades)
    end
  end

  def parse_decades_hash(decades_json)
    decades = {}
    decades_json.each do |decade|
      period = decade[:periodo].match(/(\d{4}).$/)[1].to_i
      period_sym = (period - 10).to_s
      decades[period_sym] = decade[:frequencia]
    end
    decades
  end
end
