vcr_opts = {
  cassette_name: "character/wallet_journal",
}

describe Greeve::Character::WalletJournal, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::WalletJournal.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:transactions) { should be_a Greeve::Rowset }
  end

  context "transactions" do
    subject { resource.transactions.first }

    its(:date) { should eq Time.parse("2016-11-27 00:50:51 UTC") }
    its(:ref_id) { should eq 13310477034 }
    its(:ref_type_id) { should eq 54 }
    its(:owner_name_1) { should eq "Zaphoon" }
    its(:owner_id_1) { should eq 462421468 }
    its(:owner_name_2) { should eq "Secure Commerce Commission" }
    its(:owner_id_2) { should eq 1000132 }
    its(:arg_name_1) { should eq "" }
    its(:arg_id_1) { should eq 0 }
    its(:amount) { should eq BigDecimal.new("-475689.35") }
    its(:balance) { should eq BigDecimal.new("1234567.89") }
    its(:reason) { should eq "" }
    its(:tax_receiver_id) { should eq 0 }
    its(:tax_amount) { should eq 0 }
    its(:owner_1_type_id) { should eq 1375 }
    its(:owner_2_type_id) { should eq 2 }

    context "with option" do
      vcr_opts_with_from_id = {
        cassette_name: "character/wallet_journal_from_id",
      }

      context "from_id", vcr: vcr_opts_with_from_id do
        let(:from_id) { 13310477033 }

        let(:resource) {
          Greeve::Character::WalletJournal.new(character_id, from_id: from_id, key: key, vcode: vcode)
        }

        its(:date) { should eq Time.parse("2016-11-27 00:50:51 UTC") }
        its(:ref_id) { should eq 13310477030 }
        its(:ref_type_id) { should eq 46 }
        its(:owner_name_1) { should eq "Zaphoon" }
        its(:owner_id_1) { should eq 462421468 }
        its(:owner_name_2) { should eq "Federation Navy" }
        its(:owner_id_2) { should eq 1000120 }
        its(:arg_name_1) { should eq "EVE System" }
        its(:arg_id_1) { should eq 1 }
        its(:amount) { should eq BigDecimal.new("-1146771.78") }
        its(:balance) { should eq BigDecimal.new("1234567.89") }
        its(:reason) { should eq "" }
        its(:tax_receiver_id) { should eq 0 }
        its(:tax_amount) { should eq 0 }
        its(:owner_1_type_id) { should eq 1375 }
        its(:owner_2_type_id) { should eq 2 }
      end

      vcr_opts_with_row_count = {
        cassette_name: "character/wallet_journal_row_count",
      }

      context "row_count", vcr: vcr_opts_with_row_count do
        let(:row_count) { 2 }

        let(:resource) {
          Greeve::Character::WalletJournal.new(character_id, row_count: row_count, key: key, vcode: vcode)
        }

        specify { resource.transactions.count.should eq row_count }

        its(:date) { should eq Time.parse("2016-11-27 00:50:51 UTC") }
        its(:ref_id) { should eq 13310477033 }
        its(:ref_type_id) { should eq 2 }
        its(:owner_name_1) { should eq "who1 eva" }
        its(:owner_id_1) { should eq 93363822 }
        its(:owner_name_2) { should eq "Zaphoon" }
        its(:owner_id_2) { should eq 462421468 }
        its(:arg_name_1) { should eq "4455566311" }
        its(:arg_id_1) { should eq 0 }
        its(:amount) { should eq BigDecimal.new("47568935.00") }
        its(:balance) { should eq BigDecimal.new("1234567.89") }
        its(:reason) { should eq "" }
        its(:tax_receiver_id) { should eq 0 }
        its(:tax_amount) { should eq 0 }
        its(:owner_1_type_id) { should eq 1386 }
        its(:owner_2_type_id) { should eq 1375 }
      end
    end
  end
end
