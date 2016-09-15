describe Greeve::Corporation::MemberTracking do
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/corp/MemberTracking.xml.aspx" }
  let(:xml_filename) { "corporation/member_tracking" }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) { Greeve::Corporation::MemberTracking.new }

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

    context "with extended option" do
      let(:xml_filename) { "corporation/member_tracking_extended" }
      let(:resource) { Greeve::Corporation::MemberTracking.new(extended: true) }

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
