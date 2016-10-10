vcr_opts = {
  cassette_name: "corporation/account_balance",
}

describe Greeve::Corporation::AccountBalance, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Corporation::AccountBalance.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:accounts) { should be_a Greeve::Rowset }
  end

  context "accounts" do
    subject { resource.accounts.first }

    its(:account_id) { should eq 45584084 }
    its(:account_key) { should eq 1000 }
    its(:balance) { should eq BigDecimal.new("7231642205.17") }
  end
end
