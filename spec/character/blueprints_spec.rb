vcr_opts = {
  cassette_name: "character/blueprints",
}

describe Greeve::Character::Blueprints, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Blueprints.new(character_id, key: key, vcode: vcode)
  }

  specify "constants" do
    Greeve::Character::Blueprints::BPO.should eq -1
    Greeve::Character::Blueprints::BPC.should eq -2
  end

  context "resource" do
    subject { resource }

    its(:blueprints) { should be_a Greeve::Rowset }
  end

  context "blueprints" do
    subject { resource.blueprints.first }

    its(:item_id) { should eq 1017507380602 }
    its(:location_id) { should eq 1021770302509 }
    its(:type_id) { should eq 34497 }
    its(:type_name) { should eq "Council Diplomatic Shuttle Blueprint" }
    its(:quantity) { should eq Greeve::Character::Blueprints::BPC }
    its(:flag_id) { should eq 64 }
    its(:time_efficiency) { should eq 0 }
    its(:material_efficiency) { should eq 0 }
    its(:runs) { should eq 10 }
  end
end
