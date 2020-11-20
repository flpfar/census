class NamesView
  class << self
    def rankings_by_locale(general, male, female)
      puts
      puts create_table(data: general, title: 'Ranking Geral')
      puts
      puts create_table(data: male, title: 'Ranking Masculino')
      puts
      puts create_table(data: female, title: 'Ranking Feminino')
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
