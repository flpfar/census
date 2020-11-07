require_relative './views/menu'
class Census::CLI
  def welcome
    MenuView.show
  end
end
