vcr_opts = {
  cassette_name: "character/planetary_routes",
}

describe Greeve::Character::PlanetaryRoutes, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:planet_id) { 40191481 }

  let(:resource) {
    Greeve::Character::PlanetaryRoutes.new(character_id, planet_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:routes) { should be_a Greeve::Rowset }
  end

  context "routes" do
    subject { resource.routes.first }

    its(:route_id) { should eq 758079483 }
    its(:source_pin_id) { should eq 1021935301393 }
    its(:destination_pin_id) { should eq 1021935301407 }
    its(:content_type_id) { should eq 3645 }
    its(:content_type_name) { should eq "Water" }
    its(:quantity) { should eq 40 }
    its(:waypoint_1) { should eq 1021935301389 }
    its(:waypoint_2) { should eq 1021935301396 }
    its(:waypoint_3) { should eq 0 }
    its(:waypoint_4) { should eq 0 }
    its(:waypoint_5) { should eq 0 }
  end
end
