require "pry"
require "rspec/its"
require "coveralls"
require "fileutils"

require_relative "xml_helpers"

Coveralls.wear!

require "greeve"

RSpec.configure do |c|
  c.include XMLHelpers

  # Enable "should" syntax
  c.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
  c.mock_with(:rspec)   { |c| c.syntax = [:should, :expect] }
  
  # Only run tests marked with focus: true.
  c.filter_run_including focus: true
  c.run_all_when_everything_filtered = true
  
  # Abort after first failure.
  # (Use environment variable for developer preference)
  c.fail_fast = true if ENV["RSPEC_FAIL_FAST"]
  
  # Set output formatter and enable color.
  c.formatter = "Fivemat"
  c.color = true
end
