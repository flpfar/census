require_relative '../../lib/census/repositories/state'
require_relative '../../lib/census/models/state'

describe StateRepository do
  it '#save' do
    state = State.new(id: 123456, name: 'São Paulo', initials: 'SP') # rubocop:disable Style/NumericLiterals

    result = StateRepository.save(state)

    expect(result).to be_a(PG::Result)
  end

  it '#save_batch' do
    states = []
    states << State.new(id: 111111, name: 'Estado1', initials: 'EU') # rubocop:disable Style/NumericLiterals
    states << State.new(id: 222222, name: 'Estado2', initials: 'ED') # rubocop:disable Style/NumericLiterals

    StateRepository.save_batch(states)

    expect(StateRepository.all.last.name).to eq('Estado2')
  end
end
