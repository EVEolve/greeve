vcr_opts = {
  cassette_name: "corporation/standings",
}

describe Greeve::Corporation::Standings, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) {
    Greeve::Corporation::Standings.new(key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:agents) { should be_a Greeve::Rowset }
    its(:npc_corporations) { should be_a Greeve::Rowset }
    its(:factions) { should be_a Greeve::Rowset }
  end

  context "agents" do
    subject { resource.agents.first }

    its(:from_id) { should eq 3009041 }
    its(:from_name) { should eq "Isaine Mandie" }
    its(:standing) { should eq BigDecimal.new("0.12") }
  end

  context "npc_corporations" do
    subject { resource.npc_corporations.first }

    its(:from_id) { should eq 1000005 }
    its(:from_name) { should eq "Hyasyoda Corporation" }
    its(:standing) { should eq BigDecimal.new("0.32") }
  end

  context "factions" do
    subject { resource.factions.first }

    its(:from_id) { should eq 500004 }
    its(:from_name) { should eq "Gallente Federation" }
    its(:standing) { should eq BigDecimal.new("1.22") }
  end
end
