class NamesController
  def self.index
    Views::NamesByDecades.index
  end

  def self.search_names(names_string)
    name_by_decade_result = NameByDecade.fetch_names(names_string)
    puts Views::NamesByDecades.show(name_by_decade_result)
  end
end
