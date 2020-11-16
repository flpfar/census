require_relative './views/menu'
require_relative './db/db_initializer'

class Census::CLI
  def self.welcome
    ENV['ENVIRONMENT'] = 'development'
    DBInitializer.create_tables
    MenuView.index
  end
end
