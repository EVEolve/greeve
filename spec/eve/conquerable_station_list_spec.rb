vcr_opts = {
  cassette_name: "eve/conquerable_station_list",
}

describe Greeve::Eve::ConquerableStationList, vcr: vcr_opts do
  let(:resource) { Greeve::Eve::ConquerableStationList.new }

  context "resource" do
    subject { resource }

    its(:outposts) { should be_a Greeve::Rowset }
  end

  context "outposts" do
    subject { resource.outposts.first }

    its(:station_id) { should eq 61001046 }
    its(:station_name) { should eq "W-XY4J X - Deadly Impasse" }
    its(:station_type_id) { should eq 21646 }
    its(:solar_system_id) { should eq 30001105 }
    its(:corporation_id) { should eq 98021158 }
    its(:corporation_name) { should eq "corporation federal agents space" }
    its(:x) { should eq 394820444160 }
    its(:y) { should eq -18220769280 }
    its(:z) { should eq -6131542302720 }
  end
end
