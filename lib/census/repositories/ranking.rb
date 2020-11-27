class RankingRepository
  def self.save(ranking)
    return nil if ranking.empty?

    con = DBConnection.new

    query_values = ranking.map do |item|
      "(#{item.locale_id}, '#{item.name}', #{item.rate}, #{item.ranking}, '#{item.gender}')"
    end.join(',')

    query = "INSERT INTO rankings (locale_id, name, rate, ranking, gender) VALUES #{query_values} "\
            'ON CONFLICT DO NOTHING;'

    con.exec(query)
  end

  def self.find_by_locale(locale_id, gender: nil)
    con = DBConnection.new
    ranking_json = con.exec("SELECT * FROM rankings WHERE locale_id = #{locale_id}"\
                            "#{gender ? " AND gender = '#{gender}'" : ''};")
    ranked_names = RankedNamesDeserializer.new(ranking_json).call

    Ranking.new(locale_id: locale_id, ranked_names: ranked_names, gender: gender)
  end
end
