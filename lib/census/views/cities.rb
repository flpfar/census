class CitiesView
  class << self
    def index
      print 'Informe o nome da cidade desejada: '
      city_name = gets.chomp
      CitiesController.show(city_name)
    end

    def city_name_not_found
      puts 'Cidade não encontrada.'
    end
  end
end
