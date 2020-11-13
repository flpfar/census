DEFAULT_DB = {
  host: 'db',
  user: 'postgres',
  password: 'password'
}.freeze

DEVELOPMENT_DB = DEFAULT_DB.merge({ dbname: 'census' })
TESTS_DB = DEFAULT_DB.merge({ dbname: 'census_test' })
