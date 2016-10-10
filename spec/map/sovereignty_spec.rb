vcr_opts = {
  cassette_name: "map/sovereignty",
}

describe Greeve::Map::Sovereignty, vcr: vcr_opts do
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
