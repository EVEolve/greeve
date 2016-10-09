vcr_opts = {
  cassette_name: "corporation/wallet_journal",
}

describe Greeve::Corporation::WalletJournal, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Corporation::WalletJournal.new(key: key, vcode: vcode) }

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
      vcr_opts_with_account_key = {
        cassette_name: "corporation/wallet_journal_account_1006",
      }

      context "account_key", vcr: vcr_opts_with_account_key do
        let(:account_key) { 1006 }

        let(:resource) {
          Greeve::Corporation::WalletJournal.new(account_key: account_key, key: key, vcode: vcode)
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

      vcr_opts_with_from_id = {
        cassette_name: "corporation/wallet_journal_from_id",
      }

      context "from_id", vcr: vcr_opts_with_from_id do
        let(:from_id) { 13077519467 }

        let(:resource) {
          Greeve::Corporation::WalletJournal.new(from_id: from_id, key: key, vcode: vcode)
        }

        its(:date) { should eq Time.parse("2016-09-23 04:16:27 UTC") }
        its(:ref_id) { should eq 13077519188 }
        its(:ref_type_id) { should eq 10 }
        its(:owner_name_1) { should eq "Zaphoon" }
        its(:owner_id_1) { should eq 462421468 }
        its(:owner_name_2) { should eq "Archon Corporation" }
        its(:owner_id_2) { should eq 98063277 }
        its(:arg_name_1) { should eq "" }
        its(:arg_id_1) { should eq 0 }
        its(:amount) { should eq BigDecimal.new("123456.78") }
        its(:balance) { should eq BigDecimal.new("849873912.16") }
        its(:reason) { should eq "DESC: API Test 1" }
        its(:owner_1_type_id) { should eq 1375 }
        its(:owner_2_type_id) { should eq 2 }
      end

      vcr_opts_with_row_count = {
        cassette_name: "corporation/wallet_journal_row_count",
      }

      context "row_count", vcr: vcr_opts_with_row_count do
        let(:row_count) { 1 }

        let(:resource) {
          Greeve::Corporation::WalletJournal.new(row_count: row_count, key: key, vcode: vcode)
        }

        specify { resource.entries.count.should eq row_count }
      end
    end
  end
end
