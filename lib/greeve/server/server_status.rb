require_relative "../base_item"

module Greeve
  module Server
    # Provides status of the server and the number of users logged in.
    #
    # @see https://eveonline-third-party-documentation.readthedocs.io/en/latest/xmlapi/server/serv_serverstatus.html
    class ServerStatus < Greeve::BaseItem
      endpoint "server/ServerStatus"

      attribute :server_open,    xpath: "eveapi/result/serverOpen/?[0]",    type: :boolean
      attribute :online_players, xpath: "eveapi/result/onlinePlayers/?[0]", type: :integer
    end
  end
end
