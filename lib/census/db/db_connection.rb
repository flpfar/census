require 'singleton'

class DBConnection
  include Singleton

  def initialize
    connection_params = ENV['ENVIRONMENT'] == 'test' ? TESTS_DB : DEVELOPMENT_DB

    @connection ||= PG::Connection.new(connection_params)
  end

  def exec(statement)
    @connection.exec(statement)
  end
end
