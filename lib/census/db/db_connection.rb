class DBConnection
  def initialize
    @connection_params = ENV['ENVIRONMENT'] == 'test' ? TESTS_DB : DEVELOPMENT_DB
  end

  def exec(statement)
    con = PG::Connection.new(connection_params)
    result = con.exec(statement)
    con.close
    result
  end

  private

  attr_reader :connection_params
end
