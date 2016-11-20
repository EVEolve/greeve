vcr_opts = {
  cassette_name: "character/locations",
}

describe Greeve::Character::Locations, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Locations.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:locations) { should be_a Greeve::Rowset }
  end

  context "locations" do
    subject { resource.locations.first }

    its(:item_id) { should eq 1010000493393 }
    its(:item_name) { should eq "Zephyr Biscuit" }
    its(:x) { should eq 0 }
    its(:y) { should eq 0 }
    its(:z) { should eq 0 }
  end
end
