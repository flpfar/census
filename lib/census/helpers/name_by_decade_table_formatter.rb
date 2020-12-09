class NameByDecadeTableFormatter
  def initialize(names)
    @names = names
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

  attr_accessor :names, :headings, :decades, :rows

  def create_headings
    names.each { |item| headings << item.name }
  end

  def process_decades
    names.each do |name|
      name.decades.each { |k, v| decades[k] << v }
    end
  end

  def create_rows
    decades.each { |k, v| rows << v.unshift(k) }
  end
end
