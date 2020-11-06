class Census::CLI
  def welcome
    puts 'Seja bem vindo!'
    puts
    puts 'Selecione uma opção: '
    puts '1. Ranking dos nomes mais comuns em um estado'
    puts '2. Hey'
    select_menu_option
  end

  private

  def select_menu_option
    input = gets.chomp.to_i

    case input
    when 1 then names_by_state
    when 2 then puts 'HEYYYY'
    end
  end

  def names_by_state
    states_list_output = StatesController.index
    puts states_list_output

    print 'Selecione um estado pela sigla: '
    state_initials = select_state(states_list_output)

    puts state_initials
  end

  def select_state(states_string)
    state_initials = gets.chomp.upcase

    unless state_initials.length == 2 && Regexp.new(state_initials) =~ states_string
      print 'UF inválida. Tente novamente: '
      return select_state(states_string)
    end

    state_initials
  end
end
