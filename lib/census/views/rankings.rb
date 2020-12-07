module Views
  class Rankings
    class << self
      def by_locale(locale_ranking)
        result = "\n"
        result << create_table(data: locale_ranking.general, title: 'Ranking Geral').to_s
        result << "\n"
        result << create_table(data: locale_ranking.male, title: 'Ranking Masculino').to_s
        result << "\n"
        result << create_table(data: locale_ranking.female, title: 'Ranking Feminino').to_s
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
end
