module Census
  def self.config
    @config ||= Census::Configuration.new
  end
end
