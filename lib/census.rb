require 'bundler'
Bundler.require(:default)

require_relative './census/version'
require_relative './census/cli'
Dir.glob('config/initializers/*.rb') { |file| require_relative "../#{file}" }
Dir.glob('lib/census/**/*.rb') { |file| require_relative file.gsub('lib/', './') }
