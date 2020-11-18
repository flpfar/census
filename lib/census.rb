require 'bundler'
Bundler.require(:default)

require_relative './census/version'
require_relative './census/utils/api'
require_relative './census/cli'
require_relative '../config/sidekiq'
require_relative './census/db/db_initializer'
require_relative './census/db/db_connection'
require_relative './census/controllers/menu_controller'
require_relative './census/controllers/states_controller'
require_relative './census/controllers/cities_controller'
require_relative './census/controllers/names_controller'
