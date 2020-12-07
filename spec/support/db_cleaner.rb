class DBCleaner
  def self.clean!
    ENV['ENVIRONMENT'] = 'test'
    con = DBConnection.new
    con.exec('TRUNCATE states, cities, rankings;')
  end
end
