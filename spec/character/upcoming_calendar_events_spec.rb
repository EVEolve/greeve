vcr_opts = {
  cassette_name: "character/upcoming_calendar_events",
}

describe Greeve::Character::UpcomingCalendarEvents, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::UpcomingCalendarEvents.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:upcoming_events) { should be_a Greeve::Rowset }
  end

  context "upcoming_events" do
    subject { resource.upcoming_events.first }

    its(:event_id) { should eq 1451448 }
    its(:owner_id) { should eq 1 }
    its(:owner_name) { should eq "EVE System" }
    its(:owner_type_id) { should eq 0 }
    its(:event_date) { should eq Time.parse("2016-11-15 11:00:00 UTC") }
    its(:event_title) { should eq "Deplyoment of EVE Online: Ascension" }
    its(:duration) { should eq 0 }
    its(:importance) { should eq false }
    its(:response) { should eq "Undecided" }
    its(:event_text) { should eq "\"EVE Online: Ascension\" will be deployed during an extended downtime starting at 11:00 UTC.\r\n\r\n<a href=\"https://community.eveonline.com/news/news-channels/eve-online-news/eve-online-ascension-to-be-deployed-on-tuesday-november-15th/?utm_source=ingame&utm_medium=calendar&utm_campaign=\">Deployment details</a>\r\n\r\n<a href=\"https://community.eveonline.com/news/patch-notes/patch-notes-for-eve-online-ascension/?utm_source=ingame&utm_medium=calendar&utm_campaign=\">Patch notes</a>" }
  end
end
