require_relative '../models/state'
require_relative '../db/db_connection'

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
      State.new(id: state['id'].to_i, name: state['name'], initials: state['initials'])
    end
  end

  def self.find_by_initials(initials)
    con = DBConnection.instance
    state = con.exec("SELECT * FROM states WHERE initials = '#{initials.upcase}' LIMIT 1").first
    state ? State.new(id: state['id'].to_i, name: state['name'], initials: state['initials']) : nil
  end
end
