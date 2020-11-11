require_relative '../utils/menu_options'

class Menu
  def self.input_valid?(input)
    !!MENU_OPTIONS[input.to_i]
  end
end
