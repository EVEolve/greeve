vcr_opts = {
  cassette_name: "account/characters",
}

describe Greeve::Account::Characters, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Account::Characters.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:characters) { should be_a Greeve::Rowset }
  end

  context "characters" do
    subject { resource.characters.first }

    its(:name) { should eq "Zaphoon" }
    its(:character_id) { should eq 462421468 }
    its(:corporation_name) { should eq "Archon Corporation" }
    its(:corporation_id) { should eq 98063277 }
    its(:alliance_name) { should eq "" }
    its(:alliance_id) { should eq 0 }
    its(:faction_name) { should eq "" }
    its(:faction_id) { should eq 0 }
  end
end
