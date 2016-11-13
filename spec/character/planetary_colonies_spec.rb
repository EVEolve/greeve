vcr_opts = {
  cassette_name: "character/planetary_colonies",
}

describe Greeve::Character::PlanetaryColonies, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::PlanetaryColonies.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:colonies) { should be_a Greeve::Rowset }
  end

  context "colonies" do
    subject { resource.colonies.first }

    its(:solar_system_id) { should eq 30003016 }
    its(:solar_system_name) { should eq "Junsoraert" }
    its(:planet_id) { should eq 40191481 }
    its(:planet_name) { should eq "Junsoraert IX" }
    its(:planet_type_id) { should eq 13 }
    its(:planet_type_name) { should eq "Planet (Gas)" }
    its(:owner_id) { should eq 462421468 }
    its(:owner_name) { should eq "Zaphoon" }
    its(:last_update) { should eq Time.parse("2016-11-13 04:51:49 UTC") }
    its(:upgrade_level) { should eq 4 }
    its(:number_of_pins) { should eq 12 }
  end
end
