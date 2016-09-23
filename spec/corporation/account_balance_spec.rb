describe Greeve::Corporation::AccountBalance do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/corp/AccountBalance.xml.aspx" }
  let(:xml_filename) { "corporation/account_balance" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Corporation::AccountBalance.new }

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
