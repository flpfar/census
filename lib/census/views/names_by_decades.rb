class NamesByDecadesView
  class << self
    def index
      print 'Informe o(s) nome(s) desejado(s) (separados por vírgulas): '
      names = gets.chomp
      NamesController.search_names(names)
    end

    def show(names_hash)
      return puts 'Nome(s) não encontrado(s)' if names_hash.empty? || names_hash[:names].empty?

      puts create_table(names_hash)

      return if names_hash[:names_not_found].empty?

      puts "O(s) nome(s) #{names_hash[:names_not_found].join(', ')} não foram encontrados."
    end

    private

    def create_table(names_hash) # rubocop:disable Metrics/AbcSize
      headings = ['']
      decades = Hash.new { |h, k| h[k] = [] }
      names_hash[:names].each do |item|
        headings << item.name
        item.decades.each { |k, v| decades[k] << v }
      end

      rows = []
      decades.each { |k, v| rows << v.unshift(k) }

      Terminal::Table.new headings: headings, rows: rows
    end
  end
end
