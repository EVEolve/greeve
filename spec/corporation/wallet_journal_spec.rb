describe Greeve::Corporation::WalletJournal do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/corp/WalletJournal.xml.aspx" }
  let(:xml_filename) { "corporation/wallet_journal" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Corporation::WalletJournal.new }

  context "resource" do
    subject { resource }

    its(:entries) { should be_a Greeve::Rowset }
  end

  context "entries" do
    subject { resource.entries.first }

    its(:date) { should eq Time.parse("2016-09-23 04:16:37 UTC") }
    its(:ref_id) { should eq 13077519467 }
    its(:ref_type_id) { should eq 37 }
    its(:owner_name_1) { should eq "Archon Corporation" }
    its(:owner_id_1) { should eq 98063277 }
    its(:owner_name_2) { should eq "Zaphoon" }
    its(:owner_id_2) { should eq 462421468 }
    its(:arg_name_1) { should eq "Zaphoon" }
    its(:arg_id_1) { should eq 462421468 }
    its(:amount) { should eq BigDecimal.new("-123456.78") }
    its(:balance) { should eq BigDecimal.new("849750455.38") }
    its(:reason) { should eq "DESC: API Test 2" }
    its(:owner_1_type_id) { should eq 2 }
    its(:owner_2_type_id) { should eq 1375 }

    context "with option" do
      context "account_key" do
        let(:xml_filename) { "corporation/wallet_journal_1006" }
        let(:account_key) { 1006 }

        let(:resource) {
          Greeve::Corporation::WalletJournal.new(account_key: account_key)
        }

        its(:date) { should eq Time.parse("2016-09-23 04:16:57 UTC") }
        its(:ref_id) { should eq 13077519971 }
        its(:ref_type_id) { should eq 37 }
        its(:owner_name_1) { should eq "Archon Corporation" }
        its(:owner_id_1) { should eq 98063277 }
        its(:owner_name_2) { should eq "Zaphoon" }
        its(:owner_id_2) { should eq 462421468 }
        its(:arg_name_1) { should eq "Zaphoon" }
        its(:arg_id_1) { should eq 462421468 }
        its(:amount) { should eq BigDecimal.new("-123456.78") }
        its(:balance) { should eq BigDecimal.new("20040000.00") }
        its(:reason) { should eq "DESC: API Test 4" }
        its(:owner_1_type_id) { should eq 2 }
        its(:owner_2_type_id) { should eq 1375 }
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
