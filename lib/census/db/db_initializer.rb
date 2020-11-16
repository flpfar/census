require 'pg'
require_relative './schema'
require_relative './connection_params'
require_relative './db_connection'

class DBInitializer
  def self.create_databases
    con = PG::Connection.new(DEFAULT_DB)

    create_db(con, 'census')
    create_db(con, 'census_test')

    con.close
  end

  def self.create_tables
    con = DBConnection.instance
    con.exec(CREATE_TABLES)
  end

  def self.db_exists?(con, db_name)
    !con.exec("SELECT FROM pg_database WHERE datname = '#{db_name}';").count.zero?
  end

  def self.create_db(con, db_name)
    return if db_exists?(con, db_name)

    con.exec("CREATE DATABASE #{db_name};")
  end

  private_class_method :db_exists?, :create_db
end
