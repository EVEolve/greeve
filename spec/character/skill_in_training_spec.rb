vcr_opts = {
  cassette_name: "character/skill_in_training",
}

describe Greeve::Character::SkillInTraining, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  subject {
    Greeve::Character::SkillInTraining.new(character_id, key: key, vcode: vcode)
  }

  its(:current_tq_time) { should eq Time.parse("2016-09-04 03:02:36 UTC") }
  its(:training_end_time) { should eq Time.parse("2016-09-04 19:02:52 UTC") }
  its(:training_start_time) { should eq Time.parse("2016-09-01 13:25:59 UTC") }
  its(:training_type_id) { should eq 12214 }
  its(:training_start_sp) { should eq 40000 }
  its(:training_destination_sp) { should eq 226275 }
  its(:training_to_level) { should eq 4 }
  its(:skill_in_training) { should eq true }
end
