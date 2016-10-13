vcr_opts = {
  cassette_name: "eve/character_name",
}

describe Greeve::Eve::CharacterName, vcr: vcr_opts do

  let(:ids) { 92902265 }

  let(:resource) {
    Greeve::Eve::CharacterName.new(ids)
  }

  context "resource" do
    subject { resource }

    its(:characters) { should be_a Greeve::Rowset }
  end

  context "characters" do
    subject { resource.characters.first }

    its(:name) { should eq "Remy Hart" }
    its(:character_id) { should eq ids }
  end
end
