class MenuView
  class << self
    def show
      puts 'Seja bem vindo!'
      puts
      puts '==== MENU ===='
      puts '1. Ranking dos nomes mais comuns em um estado'
      puts '2. Hey'
      options_select
    end

    private

    def options_select
      print 'Selecionar opção: '
      input = gets.chomp.to_i

      case input
      when 1 then StatesController.index
      when 2 then puts 'HEYYYY'
      end
    end
  end
end
