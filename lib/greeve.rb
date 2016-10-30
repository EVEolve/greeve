require "bigdecimal"
require "ox"
require "typhoeus"

require_relative "greeve/version"
require_relative "greeve/config"

require_relative "greeve/helpers/add_attribute"
require_relative "greeve/helpers/define_attribute_method"

require_relative "greeve/response_error"
require_relative "greeve/base_item"
require_relative "greeve/row"
require_relative "greeve/rowset"
require_relative "greeve/account/account_status"
require_relative "greeve/account/api_key_info"
require_relative "greeve/account/characters"
require_relative "greeve/api/call_list"
require_relative "greeve/character/account_balance"
require_relative "greeve/character/blueprints"
require_relative "greeve/character/character_sheet"
require_relative "greeve/character/clones"
require_relative "greeve/character/skill_in_training"
require_relative "greeve/character/skill_queue"
require_relative "greeve/character/skills"
require_relative "greeve/character/standings"
require_relative "greeve/corporation/account_balance"
require_relative "greeve/corporation/contracts"
require_relative "greeve/corporation/corporation_sheet"
require_relative "greeve/corporation/industry_jobs"
require_relative "greeve/corporation/industry_jobs_history"
require_relative "greeve/corporation/locations"
require_relative "greeve/corporation/market_orders"
require_relative "greeve/corporation/member_tracking"
require_relative "greeve/corporation/standings"
require_relative "greeve/corporation/starbase_detail"
require_relative "greeve/corporation/starbase_list"
require_relative "greeve/corporation/wallet_journal"
require_relative "greeve/corporation/wallet_transactions"
require_relative "greeve/eve/alliance_list"
require_relative "greeve/eve/character_id"
require_relative "greeve/eve/character_name"
require_relative "greeve/eve/character_info"
require_relative "greeve/map/fac_war_systems"
require_relative "greeve/map/jumps"
require_relative "greeve/map/kills"
require_relative "greeve/map/sovereignty"
require_relative "greeve/server/server_status"

# A Ruby wrapper for the EVE Online XML API.
module Greeve
  # Base URL of the EVE XML API.
  EVE_API_BASE_URL = "https://api.eveonline.com".freeze

  # Account resources.
  module Account; end
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
