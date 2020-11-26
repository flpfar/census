module Views
  class Menu
    def initialize(menu_options)
      @menu_options = menu_options
    end

    def show_options
      create_menu
    end

    private

    attr_reader :menu_options

    def create_menu
      Terminal::Table.new title: 'MENU', rows: menu_options.to_a
    end
  end
end
