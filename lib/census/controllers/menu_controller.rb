class MenuController
  def self.index
    MenuView.index
  end

  def self.show(input)
    return MenuView.invalid_input unless Menu.input_valid?(input)

    case input
    when '1' then StatesController.index
    when '2' then CitiesController.index
    when '3' then NamesController.index
    when '4' then puts 'Saindo...'
    end

    MenuView.continue unless input == '4'
  end
end
