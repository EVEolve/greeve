vcr_opts = {
  cassette_name: "server/server_status",
}

describe Greeve::Server::ServerStatus, vcr: vcr_opts do
  subject { Greeve::Server::ServerStatus.new }

  its(:server_open) { should eq true }
  its(:online_players) { should eq 27256 }
end
