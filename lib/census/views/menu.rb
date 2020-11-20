class MenuView
  class << self
    def index
      menu
    end

    def invalid_input
      puts 'Opção inválida!'
      options_select
    end

    def continue
      print "\n>> Pressione ENTER para continuar... "
      gets.chomp
      menu
    end

    private

    def menu
      system 'clear'
      puts
      puts create_menu
      options_select
    end

    def create_menu
      rows = []

      MENU_OPTIONS.each do |option_key, option_value|
        rows << [option_key.to_i, option_value]
      end

      Terminal::Table.new title: 'MENU', rows: rows
    end

    def options_select
      print 'Selecione uma opção: '
      input = gets.chomp

      MenuController.show(input)
    end
  end
end
