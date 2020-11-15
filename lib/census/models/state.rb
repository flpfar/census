require 'faraday'
require 'json'

class State
  attr_reader :id, :initials, :name

  def initialize(id:, initials:, name:)
    @id = id
    @initials = initials
    @name = name
  end

  def self.all
    response = Faraday.get "#{LOCALES_URL}/estados"
    return [] unless response.status == 200

    states = JSON.parse(response.body, symbolize_names: true)
    states.map do |state|
      new(id: state[:id], initials: state[:sigla], name: state[:nome])
    end.sort_by(&:initials)
  end

  def self.find(initials)
    all.find { |state| state.initials == initials }
  end
end
