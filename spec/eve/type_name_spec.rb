vcr_opts = {
  cassette_name: "eve/type_name",
}

describe Greeve::Eve::TypeName, vcr: vcr_opts do
  let(:ids) { 640 }

  let(:resource) {
    Greeve::Eve::TypeName.new(ids)
  }

  context "resource" do
    subject { resource }

    its(:types) { should be_a Greeve::Rowset }
  end

  context "types" do
    subject { resource.types.first }

    its(:type_id) { should eq 640 }
    its(:type_name) { should eq "Scorpion" }
  end
end
