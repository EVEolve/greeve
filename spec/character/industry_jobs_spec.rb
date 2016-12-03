vcr_opts = {
  cassette_name: "character/industry_jobs",
}

describe Greeve::Character::IndustryJobs, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::IndustryJobs.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:jobs) { should be_a Greeve::Rowset }
  end

  context "jobs" do
    subject { resource.jobs.first }

    its(:job_id) { should eq 310727768 }
    its(:installer_id) { should eq character_id }
    its(:installer_name) { should eq "Zaphoon" }
    its(:facility_id) { should eq 60014485 }
    its(:solar_system_id) { should eq 30003010 }
    its(:solar_system_name) { should eq "Halle" }
    its(:station_id) { should eq 60014485 }
    its(:activity_id) { should eq 3 }
    its(:blueprint_id) { should eq 1021769767299 }
    its(:blueprint_type_id) { should eq 11284 }
    its(:blueprint_type_name) { should eq "Cap Booster 150 Blueprint" }
    its(:blueprint_location_id) { should eq 60014485 }
    its(:output_location_id) { should eq 60014485 }
    its(:runs) { should eq 10 }
    its(:cost) { should eq BigDecimal.new("36464.00") }
    its(:licensed_runs) { should eq 300 }
    its(:probability) { should eq BigDecimal.new("1") }
    its(:product_type_id) { should eq 11284 }
    its(:product_type_name) { should eq "Cap Booster 150 Blueprint" }
    its(:status) { should eq 1 }
    its(:time_in_seconds) { should eq 310080 }
    its(:start_date) { should eq Time.parse("2016-11-25 18:49:03 UTC") }
    its(:end_date) { should eq Time.parse("2016-11-29 08:57:03 UTC") }
    its(:pause_date) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:completed_date) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:completed_character_id) { should eq 0 }
    its(:successful_runs) { should eq 0 }
  end
end
