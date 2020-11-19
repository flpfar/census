class StatesController
  def self.index
    states = State.all
    StatesView.index(states)
  end

  def self.show(initials)
    return StatesView.invalid_input unless State.input_valid?(initials)

    state = State.find(initials)
    return StatesView.not_found unless state

    NamesController.ranking_by_locale(state.id)
  end
end
