class StatesView
  class << self
    def index(states)
      puts create_table(states)
      select_state
    end

    def invalid_input
      puts 'Entrada inválida!'
      select_state
    end

    def not_found
      puts 'Estado não encontrado.'
    end

    private

    def create_table(states)
      rows = []
      states.each do |state|
        rows << [state.initials, state.name]
      end
      Terminal::Table.new headings: %w[Sigla Estado], rows: rows
    end

    def select_state
      print 'Selecione um estado pela sigla: '
      input = gets.chomp.upcase
      StatesController.show(input)
    end
  end
end
