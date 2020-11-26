class DBCleaner
  def self.clean!
    ENV['ENVIRONMENT'] = 'test'
    con = DBConnection.instance
    con.exec('TRUNCATE states, cities, rankings;')
  end
end
