class Menu
  OPTIONS = {
    '1' => { text: 'Ranking dos nomes mais comuns em um estado', action: -> { StatesController.index } },
    '2' => { text: 'Ranking dos nomes mais comuns em uma cidade', action: -> { CitiesController.index } },
    '3' => { text: 'Frequência do uso de um nome ao longo dos anos', action: -> { NamesController.index } },
    '0' => { text: 'Sair', action: -> { puts 'Saindo...' } }
  }.freeze

  def initialize
    @option = nil
  end

  def call
    loop do
      show_options
      receive_option_input
      execute_option
      break if exit_option_selected?

      press_enter_to_continue
    end
  end

  private

  attr_accessor :option

  def show_options
    puts
    puts Views::Menu.new(menu_options).show_options
    print 'Selecione uma opção: '
  end

  def receive_option_input
    loop do
      input = gets.chomp
      break self.option = input if input_valid?(input)

      print 'Opção inválida. Tente novamente: '
    end
  end

  def execute_option
    OPTIONS[option][:action].call
  end

  def exit_option_selected?
    option == '0'
  end

  def press_enter_to_continue
    print "\n>> Pressione ENTER para continuar... "
    gets.chomp
  end

  def menu_options
    OPTIONS.transform_values { |v| v[:text] }
  end

  def input_valid?(input)
    OPTIONS.keys.include?(input)
  end
end
