vcr_opts = {
  cassette_name: "corporation/locations",
}

describe Greeve::Corporation::Locations, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:ids) { 1020171077193 }

  let(:resource) {
    Greeve::Corporation::Locations.new(ids, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:locations) { should be_a Greeve::Rowset }
  end

  context "locations" do
    subject { resource.locations.first }

    its(:item_id) { should eq 1020171077193 }
    its(:item_name) { should eq "Gallente Control Tower" }
    its(:x) { should eq -67142925360 }
    its(:y) { should eq -8145422240 }
    its(:z) { should eq -1403156520 }
  end
end
