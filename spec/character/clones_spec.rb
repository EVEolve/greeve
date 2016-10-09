vcr_opts = {
  cassette_name: "character/clones",
}

describe Greeve::Character::Clones, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Clones.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:dob) { should eq Time.parse("2010-01-27 03:14:00 UTC") }
    its(:race) { should eq "Caldari" }
    its(:bloodline_id) { should eq 2 }
    its(:bloodline) { should eq "Civire" }
    its(:ancestry_id) { should eq 7 }
    its(:ancestry) { should eq "Entrepreneurs" }
    its(:gender) { should eq "Male" }
    its(:free_respecs) { should eq 3 }
    its(:clone_jump_date) { should eq Time.parse("2013-06-06 01:43:31 UTC") }
    its(:last_respec_date) { should eq Time.parse("2015-01-17 17:17:15 UTC") }
    its(:last_timed_respec) { should eq Time.parse("2015-01-17 17:17:15 UTC") }
    its(:remote_station_date) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:jump_activation) { should eq Time.parse("0001-01-01 00:00:00 UTC") }
    its(:jump_fatigue) { should eq Time.parse("0001-01-02 00:00:00 UTC") }
    its(:jump_last_update) { should eq Time.parse("0001-01-03 00:00:00 UTC") }

    its(:intelligence) { should eq 22 }
    its(:memory) { should eq 17 }
    its(:charisma) { should eq 16 }
    its(:perception) { should eq 21 }
    its(:willpower) { should eq 20 }

    its(:implants) { should be_a Greeve::Rowset }
    its(:jump_clones) { should be_a Greeve::Rowset }
    its(:jump_clone_implants) { should be_a Greeve::Rowset }
  end

  context "implants" do
    subject { resource.implants.first }

    its(:type_id) { should eq 10222 }
    its(:type_name) { should eq "Cybernetic Subprocessor - Improved" }
  end

  context "jump_clones" do
    subject { resource.jump_clones.first }

    its(:jump_clone_id) { should eq 16126532 }
    its(:type_id) { should eq 164 }
    its(:location_id) { should eq 60007627 }
    its(:clone_name) { should eq "Test Clone" }
  end

  context "jump_clone_implants" do
    subject { resource.jump_clone_implants.first }

    its(:jump_clone_id) { should eq 16126532 }
    its(:type_id) { should eq 10208 }
    its(:type_name) { should eq "Memory Augmentation - Standard" }
  end
end
