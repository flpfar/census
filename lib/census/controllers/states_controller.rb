class StatesController
  def self.ranking
    state = select_state
    return puts Views::States.not_found unless state

    NamesController.ranking_by_locale(state.id)
  end

  def self.select_state
    states = State.all.sort_by(&:initials)
    print Views::States.show_states(states)
    state_input = gets.chomp.upcase
    State.find(state_input)
  end

  private_class_method :select_state
end
