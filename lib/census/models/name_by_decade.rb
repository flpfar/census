class NameByDecade
  attr_reader :name, :decades

  def initialize(name:, decades:)
    @name = name
    @decades = decades
  end

  def self.fetch_names(names_string)
    names_arr = NamesInputProcessor.new(names_string).call
    return {} if names_arr.empty?

    names_hash = NamesApi.new(names_arr).fetch_data
    result = process_response(names_hash)
    names_not_found = (names_arr - result[:names_found]) || []
    { names: result[:names], names_not_found: names_not_found }
  end

  def self.process_response(names)
    names_found = []
    names_by_decade_list = names.map do |item|
      name = item[:nome].downcase
      names_found << name
      decades = decades_hash(item[:res])
      NameByDecade.new(name: name, decades: decades)
    end

    { names: names_by_decade_list, names_found: names_found }
  end

  def self.decades_hash(decades_json)
    decades = {}
    decades_json.each do |decade|
      period = decade[:periodo].match(/(\d{4}).$/)[1].to_i
      period_sym = (period - 10).to_s
      decades[period_sym] = decade[:frequencia]
    end
    decades
  end

  private_class_method :process_response, :decades_hash
end
