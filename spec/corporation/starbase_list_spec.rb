vcr_opts = {
  cassette_name: "corporation/starbase_list",
}

describe Greeve::Corporation::StarbaseList, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) {
    Greeve::Corporation::StarbaseList.new(key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:starbases) { should be_a Greeve::Rowset }
  end

  context "starbases" do
    subject { resource.starbases.first }

    its(:item_id) { should eq 100449451 }
    its(:type_id) { should eq 27538 }
    its(:location_id) { should eq 30000163 }
    its(:moon_id) { should eq 40010395 }
    its(:state) { should eq 4 }
    its(:state_timestamp) { should eq Time.parse("2011-12-08 20:03:41 UTC") }
    its(:online_timestamp) { should eq Time.parse("2009-06-04 07:00:51 UTC") }
    its(:standing_owner_id) { should eq 673381830 }
  end
end
