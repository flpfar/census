require_relative '../controllers/names_controller'

class StatesView
  class << self
    def index(states)
      puts create_table(states)
      print 'Selecione um estado pela sigla: '
      select_state(states)
    end

    private

    def create_table(states)
      rows = []
      states.each do |state|
        rows << [state.initials, state.name]
      end
      Terminal::Table.new headings: %w[Sigla Estado], rows: rows
    end

    def select_state(states)
      state_initials = gets.chomp.upcase
      state = validate_state(states, state_initials)

      unless state
        print 'UF inválida. Tente novamente: '
        return select_state(states)
      end

      NamesController.ranking_by_locale(state.id)
    end

    def validate_state(states, state_initials)
      states.find { |state| state.initials == state_initials }
    end
  end
end
