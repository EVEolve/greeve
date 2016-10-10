vcr_opts = {
  cassette_name: "eve/character_id",
}

describe Greeve::Eve::CharacterID, vcr: vcr_opts do

  let(:name) { "Remy Hart" }

  let(:resource) {
    Greeve::Eve::CharacterID.new(name)
  }

  context "resource" do
    subject { resource }

    its(:characters) { should be_a Greeve::Rowset }
  end

  context "characters" do
    subject { resource.characters.first }

    its(:name) { should eq name }
    its(:character_id) { should eq 92902265 }
  end
end
