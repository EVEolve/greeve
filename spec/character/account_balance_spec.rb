vcr_opts = {
  cassette_name: "character/account_balance",
}

describe Greeve::Character::AccountBalance, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::AccountBalance.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:accounts) { should be_a Greeve::Rowset }
  end

  context "accounts" do
    subject { resource.accounts.first }

    its(:account_id) { should eq 34447261 }
    its(:account_key) { should eq 1000 }
    its(:balance) { should eq BigDecimal.new("1234567.89") }
  end
end
