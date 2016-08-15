require "ox"
require "typhoeus"

require_relative "greeve/version"

require_relative "greeve/api/base_item"
require_relative "greeve/api/character_info"

# A Ruby wrapper for the EVE Online XML API.
module Greeve
end

# ------------------------------------------------------------------------------
# TODO: Remove

# BASE_URL = "https://api.eveonline.com/eve"

# response = Typhoeus.get("#{BASE_URL}/CharacterInfo.xml.aspx?characterID=462421468")
# character_info = Ox.parse(response.body)
# result = character_info.locate("eveapi/result").first
# c = Greeve::API::CharacterInfo.new(result)

# require "pry"; binding.pry
