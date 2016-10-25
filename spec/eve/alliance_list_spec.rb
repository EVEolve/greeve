vcr_opts_version_1 = {
  cassette_name: "eve/alliance_list_version_1",
}

describe Greeve::Eve::AllianceList, vcr: vcr_opts_version_1 do
  let(:version) { 1 }

  let(:resource) {
    Greeve::Eve::AllianceList.new(version)
  }

  context "resource" do
    subject { resource }

    its(:alliances) { should be_a Greeve::Rowset }
  end

  context "alliances" do
    subject { resource.alliances.first }

    its(:name) { should eq "Goonswarm Federation" }
    its(:short_name) { should eq "CONDI" }
    its(:alliance_id) { should eq 1354830081 }
    its(:executor_corp_id) { should eq 1344654522 }
    its(:member_count) { should eq 17585 }
    its(:start_date) { should eq Time.parse("2010-06-01 05:36:00 UTC") }
  end

  describe "version=0 is not implemented" do
    let(:version) { 0 }

    specify do
      expect { resource }.to raise_error(ArgumentError)
    end
  end 
end
