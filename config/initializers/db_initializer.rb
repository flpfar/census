class DBInitializer
  def self.create_databases
    con = PG::Connection.new(DEFAULT_DB)

    create_db(con, 'census')
    create_db(con, 'census_test')

    con.close
    create_tables
  end

  def self.create_tables
    con = DBConnection.new
    con.exec(REMOVE_NOTICE_IF_TABLE_EXISTS + CREATE_TABLES)
  end

  def self.db_exists?(con, db_name)
    !con.exec("SELECT FROM pg_database WHERE datname = '#{db_name}';").count.zero?
  end

  def self.create_db(con, db_name)
    return if db_exists?(con, db_name)

    con.exec("CREATE DATABASE #{db_name};")
  end

  private_class_method :db_exists?, :create_db, :create_tables
end
