vcr_opts = {
  cassette_name: "character/wallet_transactions",
}

describe Greeve::Character::WalletTransactions, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::WalletTransactions.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:transactions) { should be_a Greeve::Rowset }
  end

  context "transactions" do
    subject { resource.transactions.first }

    its(:transaction_date_time) { should eq Time.parse("2016-11-20 20:00:54 UTC") }
    its(:transaction_id) { should eq 4448553214 }
    its(:quantity) { should eq 1 }
    its(:type_name) { should eq "Veldspar Mining Crystal I Blueprint" }
    its(:type_id) { should eq 18067 }
    its(:price) { should eq BigDecimal.new("100000.00") }
    its(:client_id) { should eq 1000097 }
    its(:client_name) { should eq "Material Acquisition" }
    its(:station_id) { should eq 60009520 }
    its(:station_name) { should eq "Bereye VI - Moon 2 - Material Acquisition Refinery" }
    its(:transaction_type) { should eq "buy" }
    its(:transaction_for) { should eq "personal" }
    its(:journal_transaction_id) { should eq 13277445147 }
    its(:client_type_id) { should eq 2 }

    context "with option" do
      vcr_opts_with_from_id = {
        cassette_name: "character/wallet_transactions_from_id",
      }

      context "from_id", vcr: vcr_opts_with_from_id do
        let(:from_id) { 4431459106 }

        let(:resource) {
          Greeve::Character::WalletTransactions.new(character_id, from_id: from_id, key: key, vcode: vcode)
        }

        its(:transaction_date_time) { should eq Time.parse("2016-10-29 19:47:44 UTC") }
        its(:transaction_id) { should eq 4431458993 }
        its(:quantity) { should eq 2970 }
        its(:type_name) { should eq "Coolant" }
        its(:type_id) { should eq 9832 }
        its(:price) { should eq BigDecimal.new("9600.02") }
        its(:client_id) { should eq 1080270316 }
        its(:client_name) { should eq "Gaius Xenon" }
        its(:station_id) { should eq 60011866 }
        its(:station_name) { should eq "Dodixie IX - Moon 20 - Federation Navy Assembly Plant" }
        its(:transaction_type) { should eq "sell" }
        its(:transaction_for) { should eq "personal" }
        its(:journal_transaction_id) { should eq 13194447358 }
        its(:client_type_id) { should eq 1378 }
      end

      vcr_opts_with_row_count = {
        cassette_name: "character/wallet_transactions_row_count",
      }

      context "row_count", vcr: vcr_opts_with_row_count do
        let(:row_count) { 2 }

        let(:resource) {
          Greeve::Character::WalletTransactions.new(character_id, row_count: row_count, key: key, vcode: vcode)
        }

        specify { resource.transactions.count.should eq row_count }

        its(:transaction_date_time) { should eq Time.parse("2016-11-27 00:50:51 UTC") }
        its(:transaction_id) { should eq 4455566311 }
        its(:quantity) { should eq 4700 }
        its(:type_name) { should eq "Coolant" }
        its(:type_id) { should eq 9832 }
        its(:price) { should eq BigDecimal.new("10121.05") }
        its(:client_id) { should eq 93363822 }
        its(:client_name) { should eq "who1 eva" }
        its(:station_id) { should eq 60011866 }
        its(:station_name) { should eq "Dodixie IX - Moon 20 - Federation Navy Assembly Plant" }
        its(:transaction_type) { should eq "sell" }
        its(:transaction_for) { should eq "personal" }
        its(:journal_transaction_id) { should eq 13310477035 }
        its(:client_type_id) { should eq 1386 }
      end
    end
  end
end
