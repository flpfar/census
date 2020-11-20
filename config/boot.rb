require 'bundler'
Bundler.require(:default)

require_relative '../lib/census'

DBInitializer.create_databases
