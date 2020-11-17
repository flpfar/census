require_relative '../models/state'

class StateRepository
  def self.save(state)
    con = DBConnection.instance
    con.exec('INSERT INTO states (id, name, initials)'\
              "VALUES (#{state.id}, '#{state.name}', '#{state.initials}')"\
              'ON CONFLICT DO NOTHING;')
  end

  def self.save_batch(states)
    con = DBConnection.instance

    query_values = states.map do |state|
      "(#{state.id}, '#{state.name}', '#{state.initials}')"
    end.join(',')

    query = "INSERT INTO states (id, name, initials) VALUES #{query_values};"
    con.exec(query)
  end

  def self.all
    con = DBConnection.instance
    states = con.exec('SELECT * FROM states')

    states.map do |state|
      State.new(id: state['id'], name: state['name'], initials: state['initials'])
    end
  end

  def self.find_by_initials(initials)
    con = DBConnection.instance
    state = con.exec("SELECT * FROM states WHERE initials ILIKE '#{initials}' LIMIT 1").first
    return nil unless state

    State.new(id: state['id'], name: state['name'], initials: state['initials'])
  end
end
