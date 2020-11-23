module Views
  class Menu
    class << self
      def show_options(menu_options)
        create_menu(menu_options)
      end

      private

      def create_menu(menu_options)
        rows = []

        menu_options.each do |option_key, option_value|
          rows << [option_key.to_i, option_value]
        end

        Terminal::Table.new title: 'MENU', rows: rows
      end
    end
  end
end
