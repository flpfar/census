class StatesController
  def ranking
    state = select_state
    return puts Views::States.not_found unless state

    NamesController.ranking_by_locale(state.id)
  end

  private

  def select_state
    states = State.all.sort_by(&:initials)
    print Views::States.show_states(states)
    state_input = gets.chomp.upcase
    State.find(state_input)
  end
end
