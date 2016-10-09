require_relative "lib/greeve/version"

Gem::Specification.new do |s|
  s.name        = "greeve"
  s.version     = Greeve::VERSION
  s.date        = Time.now.strftime "%Y-%m-%d"
  s.summary     = "A Ruby wrapper for the EVE Online XML API."
  s.description = "A Ruby wrapper for the EVE Online XML API."

  s.homepage    = "https://github.com/EVEolve/greeve"
  s.authors     = ["Alex McLain"]
  s.email       = ["alex@alexmclain.com"]
  s.license     = "MIT"

  s.files = [
      "CONTRIBUTING.md",
      "LICENSE",
      "README.md",
    ] +
    Dir[
      # "bin/**/*",
      "lib/**/*",
      "doc/**/*",
    ]

  s.executables = []

  s.add_dependency "ox", "~> 2.4", ">= 2.4.4"
  s.add_dependency "typhoeus", "~> 1.1"

  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_development_dependency "pry"
  s.add_development_dependency "rb-readline"
  s.add_development_dependency "rspec", "~>3.5"
  s.add_development_dependency "rspec-its", "~> 1.2"
  s.add_development_dependency "fivemat"
  s.add_development_dependency "vcr", "~> 3.0", ">= 3.0.3"
end
