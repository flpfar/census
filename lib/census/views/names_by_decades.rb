module Views
  class NamesByDecades
    class << self
      def index
        print 'Informe o(s) nome(s) desejado(s) (separados por vírgulas): '
        names = gets.chomp
        NamesController.search_names(names)
      end

      def show(names_result)
        return 'Nome(s) não encontrado(s)' if names_result.nil? || names_result.names.empty?

        create_table(names_result).to_s + names_not_found(names_result)
      end

      private

      def create_table(names_result)
        NameByDecadeTableFormatter.new(names_result.names).call
      end

      def names_not_found(names_result)
        return '' if names_result.names_not_found.empty?

        "\nNome(s) não encontrado(s): '#{names_result.names_not_found.join(', ')}'."
      end
    end
  end
end
