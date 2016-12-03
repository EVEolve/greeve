vcr_opts = {
  cassette_name: "character/contract_items",
}

describe Greeve::Character::ContractItems, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:contract_id) { 111278568 }

  let(:resource) {
    Greeve::Character::ContractItems.new(character_id, contract_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:item_list) { should be_a Greeve::Rowset }
  end

  context "item_list" do
    subject { resource.item_list.first }

    its(:record_id) { should eq 2071907671 }
    its(:type_id) { should eq 215 }
    its(:quantity) { should eq 1000 }
    its(:raw_quantity) { should eq nil }
    its(:singleton) { should eq false }
    its(:included) { should eq true }
  end
end
