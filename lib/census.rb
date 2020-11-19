require_relative '../config/initializers/api_params'
require_relative './census/version'
require_relative './census/cli'
require_relative './census/db/db_initializer'
require_relative './census/db/db_connection'
require_relative './census/controllers/menu_controller'
require_relative './census/controllers/states_controller'
require_relative './census/controllers/cities_controller'
require_relative './census/controllers/names_controller'

require 'bundler'
Bundler.require(:default)
