require 'yaml'
API_CONFIG_FILE = YAML.load_file('./config/api.yml').freeze

API_CONFIG_FILE.each { |k, v| Object.const_set(k.upcase, v) }
