module Census
  class Configuration
    require 'yaml'
    attr_reader :locales_url, :names_url

    def initialize
      api_config_file = YAML.load_file('./config/api.yml')
      @locales_url = api_config_file['locales_url']
      @names_url = api_config_file['names_url']
    end
  end
end
