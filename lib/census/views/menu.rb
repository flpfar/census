class MenuView
  class << self
    def show
      puts 'Seja bem vindo!'
      menu
    end

    private

    def menu
      puts
      rows = []
      rows << [1, 'Ranking dos nomes mais comuns em um estado']
      rows << [2, 'Ranking dos nomes mais comuns em uma cidade']
      rows << [3, 'Heyy']
      puts Terminal::Table.new title: 'MENU', rows: rows
      options_select
    end

    def continue
      print "\n>> Pressione ENTER para continuar... "
      gets.chomp
      menu
    end

    def options_select
      print 'Selecione uma opção: '
      input = gets.chomp.to_i

      case input
      when 1 then StatesController.index
      when 2 then CitiesController.index
      when 3 then puts 'HEYYYY'
      end

      continue unless input == 3
    end
  end
end
