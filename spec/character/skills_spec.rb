vcr_opts = {
  cassette_name: "character/skills",
}

describe Greeve::Character::Skills, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Skills.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:free_skill_points) { should eq 0 }
    its(:skills) { should be_a Greeve::Rowset }
  end

  context "skills" do
    subject { resource.skills.first }

    its(:type_id) { should eq 2403 }
    its(:type_name) { should eq "Advanced Planetology" }
    its(:skillpoints) { should eq 40000 }
    its(:level) { should eq 3 }
    its(:published) { should eq true }
  end
end
