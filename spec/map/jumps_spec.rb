describe Greeve::Map::Jumps do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/map/Jumps.xml.aspx" }
  let(:xml_filename) { "map/jumps" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Map::Jumps.new }

  context "resource" do
    subject { resource }

    its(:solar_systems) { should be_a Greeve::Rowset }
  end

  context "solar system" do
    subject { resource.solar_systems.first }

    its(:solar_system_id) { should eq 30000086 }
    its(:ship_jumps) { should eq 19 }
  end
end
