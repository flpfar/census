class NameByDecade
  attr_reader :name, :decades

  def initialize(name:, decades:)
    @name = name
    @decades = decades
  end

  def self.fetch_names(names_input)
    names_arr = NamesInputProcessor.new(names_input).call
    return nil if names_arr.empty?

    names_hash = NamesApi.new(names_arr).fetch_data
    parsed_names = NameByDecadeParser.new(names_hash).call
    NameByDecadeResult.new(parsed_names, names_arr)
  end
end
