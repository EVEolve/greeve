describe Greeve::Corporation::WalletTransactions do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/corp/WalletTransactions.xml.aspx" }
  let(:xml_filename) { "corporation/wallet_transactions" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Corporation::WalletTransactions.new }

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
      context "account_key" do
        let(:xml_filename) { "corporation/wallet_transactions_1006" }
        let(:account_key) { 1006 }

        let(:resource) {
          Greeve::Corporation::WalletTransactions.new(account_key: account_key)
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

      context "from_id" do
        # Depends on issue #109 being implemented so query params can be tested.
        xspecify
      end

      context "row_count" do
        # Depends on issue #109 being implemented so query params can be tested.
        xspecify
      end
    end
  end
end
