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

    context "general_settings" do
      subject { resource.general_settings }

      its(:usage_flags) { should eq 3 }
      its(:deploy_flags) { should eq 0 }
      its(:allow_corporation_members) { should eq true }
      its(:allow_alliance_members) { should eq true }
    end

    context "combat_settings" do
      subject { resource.combat_settings }

      context "use_standings_from" do
        subject { resource.combat_settings.use_standings_from }

        its(:owner_id) { should eq 154683985 }
      end

      context "on_standing_drop" do
        subject { resource.combat_settings.on_standing_drop }

        its(:standing) { should eq 990 }
      end

      context "on_status_drop" do
        subject { resource.combat_settings.on_status_drop }

        its(:enabled) { should eq false }
        its(:standing) { should eq 0 }
      end

      context "on_aggression" do
        subject { resource.combat_settings.on_aggression }

        its(:enabled) { should eq false }
      end

      context "on_corporation_war" do
        subject { resource.combat_settings.on_corporation_war }

        its(:enabled) { should eq true }
      end
    end

    its(:fuel) { should be_a Greeve::Rowset }
  end

  context "fuel" do
    subject { resource.fuel.first }

    its(:type_id) { should eq 16275 }
    its(:quantity) { should eq 2447 }
  end
end
