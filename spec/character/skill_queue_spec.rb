describe Greeve::Character::SkillQueue do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/char/SkillQueue.xml.aspx" }
  let(:xml_filename) { "character/skill_queue" }
  let(:character_id) { 462421468 }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  let(:resource) {
    Greeve::Character::SkillQueue.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:skillqueue) { should be_a Greeve::Rowset }
  end

  context "skillqueue" do
    subject { resource.skillqueue.first }

    context "in training" do
      its(:queue_position) { should eq 0 }
      its(:type_id) { should eq 12214 }
      its(:level) { should eq 4 }
      its(:start_sp) { should eq 40000 }
      its(:end_sp) { should eq 226275 }
      its(:start_time) { should eq Time.parse("2016-09-01 13:25:59 UTC") }
      its(:end_time) { should eq Time.parse("2016-09-04 19:02:52 UTC") }
    end

    context "paused" do
      let(:xml_filename) { "character/skill_queue_paused" }

      subject { resource.skillqueue.first }

      its(:queue_position) { should eq 0 }
      its(:type_id) { should eq 3363 }
      its(:level) { should eq 3 }
      its(:start_sp) { should eq 1415 }
      its(:end_sp) { should eq 8000 }
      its(:start_time) { should be nil }
      its(:end_time) { should be nil }
    end
  end
end
