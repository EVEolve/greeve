vcr_opts = {
  cassette_name: "corporation/member_tracking",
}

describe Greeve::Corporation::MemberTracking, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Corporation::MemberTracking.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:members) { should be_a Greeve::Rowset }
  end

  context "members" do
    subject { resource.members.first }

    its(:character_id) { should eq 462421468 }
    its(:name) { should eq "Zaphoon" }
    its(:start_date_time) { should eq Time.parse("2016-07-24 02:57:00 UTC") }
    its(:base_id) { should eq 0 }
    its(:base) { should eq "" }
    its(:title) { should eq "Director" }
    its(:logon_date_time) { should eq nil }
    its(:logoff_date_time) { should eq nil }
    its(:location_id) { should eq nil }
    its(:location) { should eq nil }
    its(:ship_type_id) { should eq nil }
    its(:ship_type) { should eq nil }
    its(:roles) { should eq nil }
    its(:grantable_roles) { should eq nil }

    vcr_opts_extended = {
      cassette_name: "corporation/member_tracking_extended",
    }

    context "with extended option", vcr: vcr_opts_extended do
      let(:resource) { Greeve::Corporation::MemberTracking.new(extended: true, key: key, vcode: vcode) }

      its(:character_id) { should eq 462421468 }
      its(:name) { should eq "Zaphoon" }
      its(:start_date_time) { should eq Time.parse("2016-07-24 02:57:00 UTC") }
      its(:base_id) { should eq 0 }
      its(:base) { should eq "" }
      its(:title) { should eq "Director" }
      its(:logon_date_time) { should eq Time.parse("2016-09-14 16:05:07 UTC") }
      its(:logoff_date_time) { should eq Time.parse("2016-09-14 16:08:38 UTC") }
      its(:location_id) { should eq 60014485 }
      its(:location) { should eq "Halle X - Moon 4 - X-Sense Chemical Refinery" }
      its(:ship_type_id) { should eq 12032 }
      its(:ship_type) { should eq "Manticore" }
      its(:roles) { should eq 9223372036854775807 }
      its(:grantable_roles) { should eq 0 }
    end
  end
end
