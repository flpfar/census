class StatesController
  def self.ranking
    state = select_state
    return puts Views::States.not_found unless state

    locale_ranking = LocaleRanking.new(state.id)
    puts Views::Rankings.by_locale(locale_ranking)
  end

  def self.store_cities_rankings
    state = select_state
    return puts Views::States.not_found unless state

    state.cities.each do |city|
      StoreRankingWorker.perform_async(city.id)
    end

    puts Views::States.storing_data
  end

  def self.select_state
    states = State.all.sort_by(&:initials)
    print Views::States.show_states(states)
    state_input = gets.chomp.upcase
    State.find(state_input)
  end

  private_class_method :select_state
end
