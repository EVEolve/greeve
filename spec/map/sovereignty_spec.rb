describe Greeve::Map::Sovereignty do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/map/Sovereignty.xml.aspx" }
  let(:xml_filename) { "map/sovereignty" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Map::Sovereignty.new }

  context "resource" do
    subject { resource }

    its(:solar_systems) { should be_a Greeve::Rowset }
  end

  context "solar system" do
    subject { resource.solar_systems.first }

    its(:solar_system_id) { should eq 30000208 }
    its(:alliance_id) { should eq 498125261 }
    its(:faction_id) { should eq 0 }
    its(:corporation_id) { should eq 416584095 }
    its(:solar_system_name) { should eq "LZ-6SU" }
  end
end
