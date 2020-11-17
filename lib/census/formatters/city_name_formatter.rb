class CityNameFormatter
  def self.format(name)
    name.gsub("'", ' ').downcase
  end
end
