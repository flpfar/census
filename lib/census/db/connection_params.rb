DEFAULT_DB = {
  host: 'postgres',
  user: 'postgres',
  password: 'postgres'
}.freeze

DEVELOPMENT_DB = DEFAULT_DB.merge({ dbname: 'census' })
TESTS_DB = DEFAULT_DB.merge({ dbname: 'census_test' })
