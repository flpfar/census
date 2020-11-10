class MenuView
  class << self
    def show
      puts 'Seja bem vindo!'
      menu
    end

    private

    def menu
      system 'clear'
      puts
      rows = []
      rows << [1, 'Ranking dos nomes mais comuns em um estado']
      rows << [2, 'Ranking dos nomes mais comuns em uma cidade']
      rows << [3, 'Frequência do uso de um nome ao longo dos anos']
      rows << [4, 'Sair']
      puts Terminal::Table.new title: 'MENU', rows: rows
      options_select
    end

    def continue
      print "\n>> Pressione ENTER para continuar... "
      gets.chomp
      menu
    end

    def valid_input?(input)
      [1, 2, 3, 4].include? input
    end

    def handle_selected_option(option)
      case option
      when 1 then StatesController.index
      when 2 then CitiesController.index
      when 3 then NamesController.index
      when 4 then puts 'Saindo...'
      end

      continue unless option == 4
    end

    def options_select
      print 'Selecione uma opção: '
      input = gets.chomp.to_i

      unless valid_input?(input)
        puts 'Opção inválida!'
        return options_select
      end

      handle_selected_option(input)
    end
  end
end
