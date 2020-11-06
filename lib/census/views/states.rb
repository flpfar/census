class StatesView
  def self.index(states)
    output = ''
    states.each do |state|
      output += "#{state.initials} - #{state.name}\n"
    end
    output
  end
end
