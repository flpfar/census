require 'yaml'

DB_FILE_SETTINGS = YAML.load_file('./config/database.yml').freeze
DEFAULT_DB = DB_FILE_SETTINGS['default'].freeze
DEVELOPMENT_DB = DB_FILE_SETTINGS['development'].freeze
TESTS_DB = DB_FILE_SETTINGS['test'].freeze
