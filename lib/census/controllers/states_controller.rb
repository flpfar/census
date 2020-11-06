require_relative '../models/state'
require_relative '../views/states'

class StatesController
  def self.index
    states = State.all
    StatesView.index(states)
  end
end
