describe Greeve::Server::ServerStatus do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/server/ServerStatus.xml.aspx" }
  let(:xml_filename) { "server/server_status" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  subject { Greeve::Server::ServerStatus.new }

  its(:server_open) { should eq true }
  its(:online_players) { should eq 27256 }
end
