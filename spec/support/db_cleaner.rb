require_relative '../../lib/census/db/db_connection'

class DBCleaner
  def self.clean!
    ENV['ENVIRONMENT'] = 'test'
    con = DBConnection.instance
    con.exec('TRUNCATE states, cities;')
  end
end
