require_relative '../../lib/census/repositories/state'
require_relative '../../lib/census/models/state'

# rubocop:disable Style/NumericLiterals
describe StateRepository do
  describe '.save' do
    it 'successfully' do
      state = State.new(id: 123456, name: 'São Paulo', initials: 'SP')

      StateRepository.save(state)

      expect(State.all.first.id).to eq(123456)
    end
  end

  describe '.save_batch' do
    it 'successfully' do
      states = []
      states << State.new(id: 111111, name: 'Estado1', initials: 'EU')
      states << State.new(id: 222222, name: 'Estado2', initials: 'ED')

      StateRepository.save_batch(states)

      expect(StateRepository.all.last.name).to eq('Estado2')
      expect(StateRepository.all.last.id).to eq(222222)
    end
  end

  describe '.find_by_initials' do
    it 'should return a state when found' do
      state = State.new(id: 123456, name: 'São Paulo', initials: 'SP')
      state.save

      result = StateRepository.find_by_initials('SP')

      expect(result.name).to eq(state.name)
      expect(result.id).to eq(state.id)
      expect(result.initials).to eq(state.initials)
    end
  end

  describe '.all' do
    it 'returns an array of states' do
      State.new(id: 111111, name: 'Estado1', initials: 'EU').save
      State.new(id: 222222, name: 'Estado2', initials: 'ED').save
      State.new(id: 333333, name: 'Estado3', initials: 'ET').save

      result = StateRepository.all

      expect(result).to be_an_instance_of(Array)
      expect(result.size).to eq(3)
      expect(result.first).to be_an_instance_of(State)
    end
  end
end
# rubocop:enable Style/NumericLiterals
