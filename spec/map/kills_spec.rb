describe Greeve::Map::Kills do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/map/Kills.xml.aspx" }
  let(:xml_filename) { "map/kills" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Map::Kills.new }

  context "resource" do
    subject { resource }

    its(:solar_systems) { should be_a Greeve::Rowset }
  end

  context "solar system" do
    subject { resource.solar_systems.first }

    its(:solar_system_id) { should eq 30045307 }
    its(:ship_kills) { should eq 2 }
    its(:faction_kills) { should eq 10 }
    its(:pod_kills) { should eq 1 }
  end
end
