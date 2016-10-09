vcr_opts = {
  cassette_name: "map/jumps",
}

describe Greeve::Map::Jumps, vcr: vcr_opts do
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
