module Greeve
  # Greeve configuration options.
  class Config
    private_class_method :new

    # @return [String] HTTP client User-Agent
    def self.user_agent
      Typhoeus::Config.user_agent
    end

    # @param user_agent [String] HTTP client User-Agent
    def self.user_agent=(user_agent)
      Typhoeus::Config.user_agent = user_agent
    end
  end
end
