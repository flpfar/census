require_relative './schema'

class DBInitializer
  def self.call
    con = DBConnection.instance
    con.exec(CREATE_TABLES)
  end
end
