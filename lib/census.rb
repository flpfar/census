require 'bundler'
Bundler.require(:default)

class CensusLoader
  def initialize
    @files = []
    @files.push(*(Dir.glob('config/initializers/*.rb').map { |file| "../#{file}" }))
    @files.push(*(Dir.glob('lib/census/**/*.rb').map { |file| file.gsub('lib/', './') }))
    require_all_files
  end

  private

  attr_accessor :files

  def require_all_files # rubocop:disable Metrics/MethodLength
    i = 0
    while i < files.length
      begin
        require_relative files[i]
      rescue NameError
        i += 1
      else
        while i.positive?
          files.push(files.shift)
          i -= 1
        end
        files.shift
      end
    end
  end
end

CensusLoader.new
