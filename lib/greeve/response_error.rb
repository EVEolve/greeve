module Greeve
  # HTTP response failed.
  class ResponseError < StandardError
    # HTTP error code
    attr_reader :code
    # HTTP error message
    attr_reader :status_message

    # @option opts [Integer] :code HTTP error code
    # @option opts [String] :status_message HTTP error message
    def initialize(opts = {})
      @code = opts.fetch(:code).to_i
      @status_message = opts.fetch(:status_message).dup.freeze
    end

    # @return [String] exception error message
    def message
      "#{@code} #{@status_message}"
    end
  end
end
