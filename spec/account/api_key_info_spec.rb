vcr_opts = {
  cassette_name: "account/api_key_info",
}

describe Greeve::Account::APIKeyInfo, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Account::APIKeyInfo.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:access_mask) { should eq 4294967295 }
    its(:type) { should eq "Account" }
    its(:expires) { should eq nil }

    its(:characters) { should be_a Greeve::Rowset }
  end

  context "characters" do
    subject { resource.characters.first }

    its(:character_id) { should eq 462421468 }
    its(:character_name) { should eq "Zaphoon" }
    its(:corporation_id) { should eq 98063277 }
    its(:corporation_name) { should eq "Archon Corporation" }
    its(:alliance_id) { should eq 0 }
    its(:alliance_name) { should eq "" }
    its(:faction_id) { should eq 0 }
    its(:faction_name) { should eq "" }
  end
end
