class NameByDecadeResult
  def initialize(names_found, names_searched)
    @names_found = names_found
    @names_searched = names_searched
  end

  def names_not_found
    @names_searched - @names_found.map(&:name) || []
  end

  def names
    @names_found
  end
end
