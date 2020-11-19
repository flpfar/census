require 'bundler'
Bundler.require(:default)

Dir.glob('config/initializers/*.rb') { |file| require_relative "../#{file}" }
Dir.glob('lib/census/**/*.rb') { |file| require_relative file.gsub('lib/', './') }
