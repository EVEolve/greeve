vcr_opts = {
  cassette_name: "map/fac_war_systems",
}

describe Greeve::Map::FacWarSystems, vcr: vcr_opts do
  let(:resource) { Greeve::Map::FacWarSystems.new }

  context "resource" do
    subject { resource }

    its(:solar_systems) { should be_a Greeve::Rowset }
  end

  context "solar system" do
    subject { resource.solar_systems.first }

    its(:solar_system_id) { should eq 30003856 }
    its(:solar_system_name) { should eq "Athounon" }
    its(:occupying_faction_id) { should eq 500001 }
    its(:occupying_faction_name) { should eq "Caldari State" }
    its(:owning_faction_id) { should eq 500004 }
    its(:owning_faction_name) { should eq "Gallente Federation" }
    its(:contested) { should eq true }
    its(:victory_points) { should eq 2280 }
    its(:victory_point_threshold) { should eq 3000 }
  end
end
