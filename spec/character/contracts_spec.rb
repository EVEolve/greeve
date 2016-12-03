vcr_opts = {
  cassette_name: "character/contracts",
}

vcr_opts_with_contract_id = {
  cassette_name: "character/contracts_contract_id",
}

describe Greeve::Character::Contracts, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Contracts.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:contract_list) { should be_a Greeve::Rowset }
  end

  context "contract_list" do
    subject { resource.contract_list.first }

    its(:contract_id) { should eq 111278537 }
    its(:issuer_id) { should eq 462421468 }
    its(:issuer_corp_id) { should eq 98063277 }
    its(:assignee_id) { should eq 98063277 }
    its(:acceptor_id) { should eq 0 }
    its(:start_station_id) { should eq 60003652 }
    its(:end_station_id) { should eq 60003652 }
    its(:type) { should eq "ItemExchange" }
    its(:status) { should eq "Outstanding" }
    its(:title) { should eq "Test 1" }
    its(:for_corp) { should eq false }
    its(:availability) { should eq "Private" }
    its(:date_issued) { should eq Time.parse("2016-12-01 05:11:15 UTC") }
    its(:date_expired) { should eq Time.parse("2016-12-15 05:11:15 UTC") }
    its(:date_accepted) { should eq nil }
    its(:num_days) { should eq 0 }
    its(:date_completed) { should eq nil }
    its(:price) { should eq BigDecimal.new("4123000.00") }
    its(:reward) { should eq BigDecimal.new("0") }
    its(:collateral) { should eq BigDecimal.new("0") }
    its(:buyout) { should eq BigDecimal.new("0") }
    its(:volume) { should eq BigDecimal.new("29500") }

    context "with option contract_id", vcr: vcr_opts_with_contract_id do
      let(:contract_id) { 111278568 }

      let(:resource) {
        Greeve::Character::Contracts.new(character_id, contract_id: contract_id, key: key, vcode: vcode)
      }

      specify { resource.contract_list.count.should eq 1 }

      its(:contract_id) { should eq contract_id }
      its(:issuer_id) { should eq 462421468 }
      its(:issuer_corp_id) { should eq 98063277 }
      its(:assignee_id) { should eq 98063277 }
      its(:acceptor_id) { should eq 0 }
      its(:start_station_id) { should eq 60003652 }
      its(:end_station_id) { should eq 60003652 }
      its(:type) { should eq "ItemExchange" }
      its(:status) { should eq "Outstanding" }
      its(:title) { should eq "Test 2" }
      its(:for_corp) { should eq false }
      its(:availability) { should eq "Private" }
      its(:date_issued) { should eq Time.parse("2016-12-01 05:13:00 UTC") }
      its(:date_expired) { should eq Time.parse("2016-12-15 05:13:00 UTC") }
      its(:date_accepted) { should eq nil }
      its(:num_days) { should eq 0 }
      its(:date_completed) { should eq nil }
      its(:price) { should eq BigDecimal.new("5000.00") }
      its(:reward) { should eq BigDecimal.new("0") }
      its(:collateral) { should eq BigDecimal.new("0") }
      its(:buyout) { should eq BigDecimal.new("0") }
      its(:volume) { should eq BigDecimal.new("10") }
    end
  end
end
