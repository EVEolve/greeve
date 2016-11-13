vcr_opts = {
  cassette_name: "character/planetary_links",
}

describe Greeve::Character::PlanetaryLinks, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:planet_id) { 40191481 }

  let(:resource) {
    Greeve::Character::PlanetaryLinks.new(character_id, planet_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:links) { should be_a Greeve::Rowset }
  end

  context "links" do
    subject { resource.links.first }

    its(:source_pin_id) { should eq 1021935301380 }
    its(:destination_pin_id) { should eq 1021935301396 }
    its(:link_level) { should eq 0 }
  end
end
