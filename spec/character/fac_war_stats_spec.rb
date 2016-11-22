vcr_opts = {
  cassette_name: "character/fac_war_stats",
}

describe Greeve::Character::FacWarStats, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  subject {
    Greeve::Character::FacWarStats.new(character_id, key: key, vcode: vcode)
  }

  its(:faction_id) { should eq 500001 }
  its(:faction_name) { should eq "Caldari State" }
  its(:enlisted) { should eq Time.parse("2008-06-10 22:10:00 UTC") }
  its(:current_rank) { should eq 4 }
  its(:highest_rank) { should eq 5 }
  its(:kills_yesterday) { should eq 1 }
  its(:kills_last_week) { should eq 8 }
  its(:kills_total) { should eq 21 }
  its(:victory_points_yesterday) { should eq 120 }
  its(:victory_points_last_week) { should eq 1044 }
  its(:victory_points_total) { should eq 2063 }
end
