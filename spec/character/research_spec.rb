vcr_opts = {
  cassette_name: "character/research",
}

describe Greeve::Character::Research, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Research.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:research) { should be_a Greeve::Rowset }
  end

  context "research" do
    subject { resource.research.first }

    its(:agent_id) { should eq 3009358 }
    its(:skill_type_id) { should eq 11450 }
    its(:research_start_date) { should eq Time.parse("2014-11-27 16:34:47 UTC") }
    its(:points_per_day) { should eq BigDecimal.new("53.5346162146776") }
    its(:remainder_points) { should eq BigDecimal.new("53604.0634303189") }
  end
end
