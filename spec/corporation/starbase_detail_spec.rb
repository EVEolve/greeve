vcr_opts = {
  cassette_name: "corporation/starbase_detail",
}

describe Greeve::Corporation::StarbaseDetail, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:item_id) { 100449451 }

  let(:resource) {
    Greeve::Corporation::StarbaseDetail.new(item_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:state) { should eq 4 }
    its(:state_timestamp) { should eq Time.parse("2009-05-02 21:31:36 UTC") }
    its(:online_timestamp) { should eq Time.parse("2009-04-18 23:30:29 UTC") }
    its(:usage_flags) { should eq 3 }
    its(:deploy_flags) { should eq 0 }
    its(:allow_corporation_members) { should eq true }
    its(:allow_alliance_members) { should eq true }
    its(:use_standings_from_owner_id) { should eq 154683985 }
    its(:on_standing_drop_standing) { should eq 990 }
    its(:on_status_drop_enabled) { should eq false }
    its(:on_status_drop_standing) { should eq 0 }
    its(:on_aggression_enabled) { should eq false }
    its(:on_corporation_war_enabled) { should eq true }

    its(:fuel) { should be_a Greeve::Rowset }
  end

  context "fuel" do
    subject { resource.fuel.first }

    its(:type_id) { should eq 16275 }
    its(:quantity) { should eq 2447 }
  end
end
