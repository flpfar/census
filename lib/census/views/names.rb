require_relative '../models/name'

class NamesView
  class << self
    def index
      print 'Informe o(s) nome(s) desejado(s) (separados por vírgulas): '
      names = gets.chomp
      NamesController.search_names(names)
    end

    def rankings_by_locale(general, male, female)
      puts
      puts create_table(data: general, title: 'Ranking Geral')
      puts
      puts create_table(data: male, title: 'Ranking Masculino')
      puts
      puts create_table(data: female, title: 'Ranking Feminino')
    end

    def names_by_decades(names_hash) # rubocop:disable Metrics/AbcSize
      return puts 'Nome(s) não encontrado(s)' if names_hash[:names].empty?

      headings = ['']
      decades = Hash.new { |h, k| h[k] = [] }
      names_hash[:names].each do |item|
        headings << item.name
        item.decades.each { |k, v| decades[k] << v }
      end

      rows = []
      decades.each { |k, v| rows << v.unshift(k) }

      puts Terminal::Table.new headings: headings, rows: rows
    end

    private

    def create_table(data:, title:)
      rows = []
      data.each do |name|
        rows << [name.ranking, name.name, name.rate]
      end
      Terminal::Table.new title: title, headings: %w[Ranking Nome Frequência], rows: rows
    end
  end
end
