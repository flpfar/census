class State
  attr_reader :id, :initials, :name

  def initialize(id:, initials:, name:)
    @id = id.to_i
    @initials = StateInitialsFormatter.format(initials)
    @name = name
  end

  def save
    StateRepository.save(self)
    self
  end

  def cities
    City.find_by_state(id)
  end

  def self.all
    states_from_db = StateRepository.all
    return states_from_db unless states_from_db.empty?

    states_json = StatesApi.new.fetch_data

    states = parse_json(states_json)
    StateRepository.save_batch(states)
    StateRepository.all
  end

  def self.find(initials)
    return nil unless input_valid?(initials)

    initials = StateInitialsFormatter.format(initials)
    StateRepository.find_by_initials(initials)
  end

  def self.input_valid?(input)
    !!(input =~ /^[a-zA-Z]{2}$/)
  end

  def self.parse_json(states_json)
    states_json.map do |state|
      new(id: state[:id], initials: state[:sigla], name: state[:nome])
    end
  end

  private_class_method :input_valid?, :parse_json
end
