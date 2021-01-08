class NameByDecadeTableFormatter
  def initialize(names)
    @names_by_decades = names
    @headings = ['']
    @rows = []
    @decades = Hash.new { |h, k| h[k] = [] }
  end

  def call
    create_headings
    process_decades
    create_rows

    Terminal::Table.new headings: headings, rows: rows
  end

  private

  attr_accessor :names_by_decades, :headings, :decades, :rows

  def create_headings
    headings.concat(names_by_decades.map(&:name))
  end

  def process_decades
    names_by_decades.each do |name_by_decade|
      name_by_decade.decades.each { |k, v| decades[k] << v }
    end
  end

  def create_rows
    decades.each { |k, v| rows << v.unshift(k) }
  end
end
