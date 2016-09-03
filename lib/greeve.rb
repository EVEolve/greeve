require "bigdecimal"
require "ox"
require "typhoeus"

require_relative "greeve/version"

require_relative "greeve/helpers/add_attribute"
require_relative "greeve/helpers/define_attribute_method"

require_relative "greeve/base_item"
require_relative "greeve/row"
require_relative "greeve/rowset"
require_relative "greeve/eve/character_info"
require_relative "greeve/map/fac_war_systems"
require_relative "greeve/map/jumps"
require_relative "greeve/map/kills"
require_relative "greeve/map/sovereignty"

# A Ruby wrapper for the EVE Online XML API.
module Greeve
  # Base URL of the EVE XML API.
  EVE_API_BASE_URL = "https://api.eveonline.com".freeze

  # API resources.
  module API; end
  # Character resources.
  module Character; end
  # Corporation resources.
  module Corporation; end
  # Eve resources.
  module Eve; end
  # Map resources.
  module Map; end
  # Server resources.
  module Server; end

  # A namespace containing helper modules.
  module Helpers; end
end
