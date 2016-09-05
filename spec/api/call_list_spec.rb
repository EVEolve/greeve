describe Greeve::API::CallList do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/api/CallList.xml.aspx" }
  let(:xml_filename) { "api/call_list" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::API::CallList.new }

  context "resource" do
    subject { resource }

    its(:call_groups) { should be_a Greeve::Rowset }
    its(:calls) { should be_a Greeve::Rowset }
  end

  context "call group" do
    subject { resource.call_groups.first }

    its(:group_id) { should eq 1 }
    its(:name) { should eq "Account and Market" }
    its(:description) { should eq "Market Orders, account balance and journal history." }
  end

  context "call" do
    subject { resource.calls.first }

    its(:access_mask) { should eq 2147483648 }
    its(:type) { should eq "Character" }
    its(:name) { should eq "Clones" }
    its(:group_id) { should eq 3 }
    its(:description) { should eq "List of your implants, attributes, jump clones, and jump fatigue timers." }
  end
end
