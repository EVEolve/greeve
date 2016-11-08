vcr_opts = {
  cassette_name: "corporation/contracts",
}

vcr_opts_with_contract_id = {
  cassette_name: "corporation/contracts_contract_id",
}

describe Greeve::Corporation::Contracts, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) {
    Greeve::Corporation::Contracts.new(key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:contract_list) { should be_a Greeve::Rowset }
  end

  context "contract_list" do
    subject { resource.contract_list.first }

    its(:contract_id) { should eq 110086071 }
    its(:issuer_id) { should eq 462421468 }
    its(:issuer_corp_id) { should eq 98063277 }
    its(:assignee_id) { should eq 98063277 }
    its(:acceptor_id) { should eq 0 }
    its(:start_station_id) { should eq 60003652 }
    its(:end_station_id) { should eq 60003652 }
    its(:type) { should eq "ItemExchange" }
    its(:status) { should eq "Outstanding" }
    its(:title) { should eq "Test Contract" }
    its(:for_corp) { should eq true }
    its(:availability) { should eq "Private" }
    its(:date_issued) { should eq Time.parse("2016-10-29 20:21:23 UTC") }
    its(:date_expired) { should eq Time.parse("2016-11-12 20:21:23 UTC") }
    its(:date_accepted) { should eq nil }
    its(:date_completed) { should eq nil }
    its(:num_days) { should eq 0 }
    its(:price) { should eq BigDecimal.new("4000000.00") }
    its(:reward) { should eq BigDecimal.new("0") }
    its(:colalteral) { should eq BigDecimal.new("0") }
    its(:buyout) { should eq BigDecimal.new("0") }
    its(:volume) { should eq BigDecimal.new("29500") }

    context "with option contract_id", vcr: vcr_opts_with_contract_id do
      let(:contract_id) { 110087148 }
      let(:resource) {
        Greeve::Corporation::Contracts.new(contract_id: contract_id, key: key, vcode: vcode)
      }

      its(:contract_id) { should eq contract_id }
      its(:issuer_id) { should eq 462421468 }
      its(:issuer_corp_id) { should eq 98063277 }
      its(:assignee_id) { should eq 98063277 }
      its(:acceptor_id) { should eq 0 }
      its(:start_station_id) { should eq 60003652 }
      its(:end_station_id) { should eq 60003652 }
      its(:type) { should eq "ItemExchange" }
      its(:status) { should eq "Outstanding" }
      its(:title) { should eq "Test Incursus" }
      its(:for_corp) { should eq true }
      its(:availability) { should eq "Private" }
      its(:date_issued) { should eq Time.parse("2016-10-29 20:56:19 UTC") }
      its(:date_expired) { should eq Time.parse("2016-11-12 20:56:19 UTC") }
      its(:date_accepted) { should eq nil }
      its(:date_completed) { should eq nil }
      its(:num_days) { should eq 0 }
      its(:price) { should eq BigDecimal.new("3510000.00") }
      its(:reward) { should eq BigDecimal.new("0") }
      its(:colalteral) { should eq BigDecimal.new("0") }
      its(:buyout) { should eq BigDecimal.new("0") }
      its(:volume) { should eq BigDecimal.new("29500") }
    end
  end
end
