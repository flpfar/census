require_relative './views/menu'
require_relative './db/db_initializer'

class Census::CLI
  def self.welcome
    DBInitializer.create_tables
    MenuView.index
  end
end
