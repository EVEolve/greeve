vcr_opts = {
  cassette_name: "eve/character_affiliation",
}

describe Greeve::Eve::CharacterAffiliation, vcr: vcr_opts do
  let(:ids) { 462421468 }

  let(:resource) {
    Greeve::Eve::CharacterAffiliation.new(*ids)
  }

  context "resource" do
    subject { resource }

    its(:characters) { should be_a Greeve::Rowset }
  end

  context "characters" do
    subject { resource.characters.first }

    its(:character_id) { should eq ids }
    its(:character_name) { should eq "Zaphoon" }
    its(:corporation_id) { should eq 98063277 }
    its(:corporation_name) { should eq "Archon Corporation" }
    its(:alliance_id) { should eq 0 }
    its(:alliance_name) { should eq "" }
    its(:faction_id) { should eq 0 }
    its(:faction_name) { should eq "" }
  end
end
