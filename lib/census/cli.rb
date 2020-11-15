require_relative './views/menu'
class Census::CLI
  def welcome
    MenuView.index
  end
end
