module Views
  class States
    class << self
      def show_states(states)
        create_table(states).to_s + select_state
      end

      def not_found
        'Estado não encontrado.'
      end

      def storing_data
        'Os rankings das cidades estão sendo salvos em background.'
      end

      private

      def select_state
        "\nSelecione um estado pela sigla: "
      end

      def create_table(states)
        rows = []
        states.each do |state|
          rows << [state.initials.upcase, state.name]
        end
        Terminal::Table.new headings: %w[Sigla Estado], rows: rows
      end
    end
  end
end
