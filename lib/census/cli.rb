class Census::CLI
  def self.welcome
    ENV['ENVIRONMENT'] = 'development'
    MenuView.index
  end
end
