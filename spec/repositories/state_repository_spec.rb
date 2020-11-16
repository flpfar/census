require_relative '../../lib/census/repositories/state'
require_relative '../../lib/census/models/state'

describe StateRepository do
  # rubocop:disable Style/NumericLiterals
  it '#save' do
    state = State.new(id: 123456, name: 'São Paulo', initials: 'SP')

    StateRepository.save(state)

    expect(State.all.first.id).to eq(123456)
  end

  it '#save_batch' do
    states = []
    states << State.new(id: 111111, name: 'Estado1', initials: 'EU')
    states << State.new(id: 222222, name: 'Estado2', initials: 'ED')

    StateRepository.save_batch(states)

    expect(StateRepository.all.last.name).to eq('Estado2')
    expect(StateRepository.all.last.id).to eq(222222)
  end
  # rubocop:enable Style/NumericLiterals
end
