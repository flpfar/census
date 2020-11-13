require 'singleton'

class DBConnection
  include Singleton
  def initialize
    @connection = PG::Connection.new(host: 'db', user: 'postgres', password: 'password') if @connection.nil?
  end

  def exec(statement)
    @connection.exec(statement)
  end
end
