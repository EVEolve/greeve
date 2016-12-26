vcr_opts = {
  cassette_name: "eve/error_list",
}

describe Greeve::Eve::ErrorList, vcr: vcr_opts do
  let(:resource) { Greeve::Eve::ErrorList.new }

  context "resource" do
    subject { resource }

    its(:errors) { should be_a Greeve::Rowset }
  end

  context "errors" do
    subject { resource.errors.first }

    its(:error_code) { should eq 100 }
    its(:error_text) { should eq "Expected before ref/trans ID = 0: wallet not previously loaded." }
  end
end
