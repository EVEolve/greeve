vcr_opts = {
  cassette_name: "character/planetary_pins",
}

describe Greeve::Character::PlanetaryPins, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:planet_id) { 40191481 }

  let(:resource) {
    Greeve::Character::PlanetaryPins.new(character_id, planet_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:pins) { should be_a Greeve::Rowset }
  end

  context "pins" do
    subject { resource.pins.first }

    its(:pin_id) { should eq 1021935301380 }
    its(:type_id) { should eq 3060 }
    its(:type_name) { should eq "Gas Extractor Control Unit" }
    its(:schematic_id) { should eq 0 }
    its(:last_launch_time) { should eq Time.parse("2016-11-13 04:51:49 UTC") }
    its(:cycle_time) { should eq 15 }
    its(:quantity_per_cycle) { should eq 1259 }
    its(:install_time) { should eq Time.parse("2016-11-13 04:51:49 UTC") }
    its(:expiry_time) { should eq Time.parse("2016-11-14 04:51:49 UTC") }
    its(:content_type_id) { should eq 0 }
    its(:content_type_name) { should eq "" }
    its(:content_quantity) { should eq 0 }
    its(:longitude) { should eq BigDecimal.new("-0.426990235704") }
    its(:latitude) { should eq BigDecimal.new("0.512429971137") }
  end
end
