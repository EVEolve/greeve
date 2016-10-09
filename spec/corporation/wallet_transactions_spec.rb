vcr_opts = {
  cassette_name: "corporation/wallet_transactions",
}

describe Greeve::Corporation::WalletTransactions, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Corporation::WalletTransactions.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:transactions) { should be_a Greeve::Rowset }
  end

  context "transactions" do
    subject { resource.transactions.first }

    its(:transaction_date_time) { should eq Time.parse("2016-08-24 04:07:37 UTC") }
    its(:transaction_id) { should eq 4389147674 }
    its(:quantity) { should eq 5 }
    its(:type_name) { should eq "Hobgoblin I" }
    its(:type_id) { should eq 2454 }
    its(:price) { should eq BigDecimal.new("2900.00") }
    its(:client_id) { should eq 96634663 }
    its(:client_name) { should eq "Piscespro Zodiac" }
    its(:character_id) { should eq 462421468 }
    its(:character_name) { should eq "Zaphoon" }
    its(:station_id) { should eq 60011866 }
    its(:station_name) { should eq "Dodixie IX - Moon 20 - Federation Navy Assembly Plant" }
    its(:transaction_type) { should eq "buy" }
    its(:transaction_for) { should eq "corporation" }
    its(:journal_transaction_id) { should eq 12984444971 }
    its(:client_type_id) { should eq 1377 }

    context "with option" do
      vcr_opts_with_account_key = {
        cassette_name: "corporation/wallet_transactions_account_1006",
      }

      context "account_key", vcr: vcr_opts_with_account_key do
        let(:account_key) { 1006 }

        let(:resource) {
          Greeve::Corporation::WalletTransactions.new(account_key: account_key, key: key, vcode: vcode)
        }

        its(:transaction_date_time) { should eq Time.parse("2016-08-27 17:55:05 UTC") }
        its(:transaction_id) { should eq 4391188295 }
        its(:quantity) { should eq 12500 }
        its(:type_name) { should eq "Tritanium" }
        its(:type_id) { should eq 34 }
        its(:price) { should eq BigDecimal.new("5.24") }
        its(:client_id) { should eq 1051457831 }
        its(:client_name) { should eq "Commander Godsmack" }
        its(:character_id) { should eq 462421468 }
        its(:character_name) { should eq "Zaphoon" }
        its(:station_id) { should eq 60011866 }
        its(:station_name) { should eq "Dodixie IX - Moon 20 - Federation Navy Assembly Plant" }
        its(:transaction_type) { should eq "sell" }
        its(:transaction_for) { should eq "corporation" }
        its(:journal_transaction_id) { should eq 12994678528 }
        its(:client_type_id) { should eq 1377 }
      end

      vcr_opts_with_from_id = {
        cassette_name: "corporation/wallet_transactions_from_id",
      }

      context "from_id", vcr: vcr_opts_with_from_id do
        let(:from_id) { 4389147674 }

        let(:resource) {
          Greeve::Corporation::WalletTransactions.new(from_id: from_id, key: key, vcode: vcode)
        }

        its(:transaction_date_time) { should eq Time.parse("2016-08-24 04:07:37 UTC") }
        its(:transaction_id) { should eq 4389147672 }
        its(:quantity) { should eq 2 }
        its(:type_name) { should eq "Mining Laser Upgrade I" }
        its(:type_id) { should eq 22542 }
        its(:price) { should eq BigDecimal.new("36228.80") }
        its(:client_id) { should eq 96209930 }
        its(:client_name) { should eq "Chris Huntington" }
        its(:character_id) { should eq 462421468 }
        its(:character_name) { should eq "Zaphoon" }
        its(:station_id) { should eq 60011866 }
        its(:station_name) { should eq "Dodixie IX - Moon 20 - Federation Navy Assembly Plant" }
        its(:transaction_type) { should eq "buy" }
        its(:transaction_for) { should eq "corporation" }
        its(:journal_transaction_id) { should eq 12984444965 }
        its(:client_type_id) { should eq 1377 }
      end

      vcr_opts_with_row_count = {
        cassette_name: "corporation/wallet_transactions_row_count",
      }

      context "row_count", vcr: vcr_opts_with_row_count do
        let(:row_count) { 1 }

        let(:resource) {
          Greeve::Corporation::WalletTransactions.new(row_count: row_count, key: key, vcode: vcode)
        }

        specify { resource.transactions.count.should eq row_count }
      end
    end
  end
end
