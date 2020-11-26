class Menu
  OPTIONS = {
    '1' => { text: 'Ranking dos nomes mais comuns em um estado', class_name: StatesController, method_name: :index },
    '2' => { text: 'Ranking dos nomes mais comuns em uma cidade', class_name: CitiesController, method_name: :index },
    '3' => { text: 'Frequência do uso de um nome ao longo dos anos', class_name: NamesController, method_name: :index },
    '0' => { text: 'Sair' }
  }.freeze

  def initialize
    @option = nil
  end

  def call
    loop do
      show_options
      receive_option_input
      break if exit_option_selected?

      execute_option
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
    class_name, method_name = OPTIONS[@option].values_at(:class_name, :method_name)
    class_name.public_send(method_name)
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
