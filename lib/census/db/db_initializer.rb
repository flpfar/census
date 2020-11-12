require_relative '../db/schema'

class DBInitializer
  def self.call
    con = PG::Connection.new(host: 'db', user: 'postgres', password: 'password')
    con.exec(CREATE_TABLES)
  end
end
