vcr_opts = {
  cassette_name: "character/contract_bids",
}

describe Greeve::Character::ContractBids, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::ContractBids.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:bid_list) { should be_a Greeve::Rowset }
  end

  context "bid_list" do
    subject { resource.bid_list.first }

    its(:amount) { should eq BigDecimal.new("1000000.00") }
    its(:date_bid) { should eq Time.parse("2015-11-08 03:45:50 UTC") }
    its(:bidder_id) { should eq 92168909 }
    its(:contract_id) { should eq 98714177 }
    its(:bid_id) { should eq 4891368 }
  end
end
