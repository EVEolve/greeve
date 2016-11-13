vcr_opts = {
  cassette_name: "corporation/corporation_sheet",
}

describe Greeve::Corporation::CorporationSheet, vcr: vcr_opts do
  let(:corporation_id) { 98063277 }

  let(:resource) { Greeve::Corporation::CorporationSheet.new(corporation_id) }

  context "resource" do
    subject { resource }

    its(:corporation_id) { should eq 98063277 }
    its(:corporation_name) { should eq "Archon Corporation" }
    its(:ticker) { should eq "ACHN" }
    its(:ceo_id) { should eq 90332071 }
    its(:ceo_name) { should eq "Christy Sirois" }
    its(:station_id) { should eq 60003652 }
    its(:station_name) { should eq "Halle II - Caldari Business Tribunal" }
    its(:description) { should eq "A description of the corporation." }
    its(:url) { should eq "http://www.wraithgaming.com" }
    its(:alliance_id) { should eq 0 }
    its(:faction_id) { should eq 0 }
    its(:tax_rate) { should eq 10 }
    its(:member_count) { should eq 8 }
    its(:shares) { should eq 1000 }

    context "logo" do
      subject { resource.logo }

      its(:graphic_id) { should eq 0 }
      its(:shape1) { should eq 539 }
      its(:shape2) { should eq 511 }
      its(:shape3) { should eq 502 }
      its(:color1) { should eq 677 }
      its(:color2) { should eq 682 }
      its(:color3) { should eq 683 }
    end
  end
end
