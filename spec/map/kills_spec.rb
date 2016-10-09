vcr_opts = {
  cassette_name: "map/kills",
}

describe Greeve::Map::Kills, vcr: vcr_opts do
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
