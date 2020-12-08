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

        return create_table(names_result) if names_result.names_not_found.empty?

        "Nome(s) não encontrado(s): '#{names_result.names_not_found.join(', ')}'."
      end

      private

      def create_table(names_result) # rubocop:disable Metrics/AbcSize
        headings = ['']
        decades = Hash.new { |h, k| h[k] = [] }
        names_result.names.each do |item|
          headings << item.name
          item.decades.each { |k, v| decades[k] << v }
        end

        rows = []
        decades.each { |k, v| rows << v.unshift(k) }

        Terminal::Table.new headings: headings, rows: rows
      end
    end
  end
end
