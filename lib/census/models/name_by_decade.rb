class NameByDecade
  attr_reader :name, :decades

  def initialize(name:, decades:)
    @name = name
    @decades = decades
  end

  def self.fetch_names(names_string)
    names_arr = process_input(names_string)
    names_param = CGI.escape(names_arr.join('|'))

    response = Faraday.get "#{NAMES_URL}/#{names_param}"
    return {} unless response.status == 200

    names_hash = JSON.parse(response.body, symbolize_names: true)

    result = process_response(names_hash)

    names_not_found = (names_arr - result[:names_found]) || []

    { names: result[:names], names_not_found: names_not_found }
  end

  def self.process_input(names_string)
    names = names_string.downcase.split(/[^a-z]*\s*,\s*[^a-z]*/)
    names.map { |n| n.sub(/[\s[^a-z]].*/, '') }
    # TODO: Add parameterize
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

  private_class_method :process_response, :decades_hash, :process_input
end
