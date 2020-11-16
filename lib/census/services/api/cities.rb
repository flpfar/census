require_relative './locales'

class CitiesApi < LocalesApi
  def initialize
    super('municipios')
  end
end
