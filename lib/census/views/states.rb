require_relative '../controllers/names_controller'

class StatesView
  class << self
    def index(states)
      states.each do |state|
        puts "#{state.initials} - #{state.name}\n"
      end
      print 'Selecione um estado pela sigla: '
      select_state(states)
    end

    private

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
