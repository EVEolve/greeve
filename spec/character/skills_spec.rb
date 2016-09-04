describe Greeve::Character::Skills do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/character/Skills.xml.aspx" }
  let(:xml_filename) { "character/skills" }
  let(:character_id) { 462421468 }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

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
