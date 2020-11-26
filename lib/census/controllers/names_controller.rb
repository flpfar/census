class NamesController
  def self.index
    NamesByDecadesView.index
  end

  def self.search_names(names_string)
    result = NameByDecade.fetch_names(names_string)
    NamesByDecadesView.show(result)
  end
end
