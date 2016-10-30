vcr_opts = {
  cassette_name: "corporation/industry_jobs",
}

describe Greeve::Corporation::IndustryJobs, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) {
    Greeve::Corporation::IndustryJobs.new(key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:jobs) { should be_a Greeve::Rowset }
  end

  context "jobs" do
    subject { resource.jobs.first }

    its(:job_id) { should eq 229136101 }
    its(:installer_id) { should eq 498338451 }
    its(:installer_name) { should eq "Qoi" }
    its(:facility_id) { should eq 60006382 }
    its(:solar_system_id) { should eq 30005194 }
    its(:solar_system_name) { should eq "Cleyd" }
    its(:station_id) { should eq 60006382 }
    its(:activity_id) { should eq 1 }
    its(:blueprint_id) { should eq 1015116533326 }
    its(:blueprint_type_id) { should eq 2047 }
    its(:blueprint_type_name) { should eq "Damage Control I Blueprint" }
    its(:blueprint_location_id) { should eq 60006382 }
    its(:output_location_id) { should eq 60006382 }
    its(:runs) { should eq 1 }
    its(:cost) { should eq BigDecimal.new("118.00") }
    its(:licensed_runs) { should eq 200 }
    its(:probability) { should eq BigDecimal.new("0") }
    its(:product_type_id) { should eq 0 }
    its(:product_type_name) { should eq "" }
    its(:status) { should eq 1 }
    its(:time_in_seconds) { should eq 548 }
    its(:start_date) { should eq Time.parse("2014-07-19 15:47:06 UTC") }
    its(:end_date) { should eq Time.parse("2014-07-19 15:56:14 UTC") }
    its(:pause_date) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:completed_date) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:completed_character_id) { should eq 0 }
    its(:successful_runs) { should eq 1 }
  end
end
