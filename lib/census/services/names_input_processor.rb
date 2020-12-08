class NamesInputProcessor
  def initialize(input)
    @input = input
  end

  def call
    names = input.downcase.split(/[^a-z]*\s*,\s*[^a-z]*/)
    names.map { |n| n.sub(/[\s[^a-z]].*/, '') }.reject(&:empty?)
  end

  private

  attr_reader :input
end
