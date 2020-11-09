require_relative '../controllers/cities_controller'

class CitiesView
  class << self
    def index
      print 'Informe o nome da cidade desejada: '
      city_name = gets.chomp
      CitiesController.show(city_name)
    end
  end
end
