describe Greeve::Character::Standings do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/char/Standings.xml.aspx" }
  let(:xml_filename) { "character/standings" }
  let(:character_id) { 462421468 }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) {
    Greeve::Character::Standings.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:agents) { should be_a Greeve::Rowset }
    its(:npc_corporations) { should be_a Greeve::Rowset }
    its(:factions) { should be_a Greeve::Rowset }
  end

  context "agents" do
    subject { resource.agents.first }

    its(:from_id) { should eq 3009823 }
    its(:from_name) { should eq "Loot Astyroure" }
    its(:standing) { should eq BigDecimal.new("0.75") }
  end

  context "npc_corporations" do
    subject { resource.npc_corporations.first }

    its(:from_id) { should eq 1000003 }
    its(:from_name) { should eq "Prompt Delivery" }
    its(:standing) { should eq BigDecimal.new("0.13") }
  end

  context "factions" do
    subject { resource.factions.first }

    its(:from_id) { should eq 500001 }
    its(:from_name) { should eq "Caldari State" }
    its(:standing) { should eq BigDecimal.new("-3.88") }
  end
end
