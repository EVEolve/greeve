vcr_opts = {
  cassette_name: "character/asset_list",
}

describe Greeve::Character::AssetList, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::AssetList.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:assets) { should be_a Greeve::Rowset }
  end

  context "assets" do
    subject { resource.assets.first }

    its(:item_id) { should eq 1009196745972 }
    its(:location_id) { should eq 60001039 }
    its(:type_id) { should eq 27914 }
    its(:quantity) { should eq 1 }
    its(:flag) { should eq 4 }
    its(:singleton) { should eq true }
    its(:raw_quantity) { should eq -1 }
  end
end
