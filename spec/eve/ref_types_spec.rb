vcr_opts = {
  cassette_name: "eve/ref_types",
}

describe Greeve::Eve::RefTypes, vcr: vcr_opts do
  let(:resource) { Greeve::Eve::RefTypes.new }

  context "resource" do
    subject { resource }

    its(:ref_types) { should be_a Greeve::Rowset }
  end

  context "ref_types" do
    subject { resource.ref_types.first }

    its(:ref_type_id) { should eq 0 }
    its(:ref_type_name) { should eq "Undefined" }
  end
end
