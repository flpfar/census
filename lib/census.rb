require 'bundler'
Bundler.require(:default)

class CensusLoader
  def initialize
    @files = []
  end

  def call
    load_initializers_files
    load_project_files
    require_loaded_files
  end

  private

  attr_accessor :files

  def load_initializers_files
    Dir.glob('config/initializers/*.rb').each { |file| files << "../#{file}" }
  end

  def load_project_files
    Dir.glob('lib/census/**/*.rb').each { |file| files << file.gsub('lib/', './') }
  end

  def require_loaded_files
    files.each do |file|
      require_relative file
    rescue NameError
      files << file
    end
  end
end

CensusLoader.new.call
