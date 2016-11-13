vcr_opts = {
  cassette_name: "character/calendar_event_attendees",
}

vcr_opts_multiple_ids = {
  cassette_name: "character/calendar_event_attendees_multiple_ids",
}

describe Greeve::Character::CalendarEventAttendees, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:event_ids) { 1451448 }

  let(:resource) {
    Greeve::Character::CalendarEventAttendees.new(character_id, event_ids, key: key, vcode: vcode)
  }

  context "single event id" do
    context "resource" do
      subject { resource }

      its(:event_attendees) { should be_a Greeve::Rowset }
    end

    context "event_attendees" do
      subject { resource.event_attendees.first }

      its(:event_id) { should eq 1451448 }
      its(:character_id) { should eq 1 }
      its(:character_name) { should eq "EVE System" }
      its(:response) { should eq "Accepted" }
    end
  end

  context "multiple event ids", vcr: vcr_opts_multiple_ids do
    let(:event_ids) { [1451448, 1450975] }

    context "resource" do
      subject { resource }

      its(:event_attendees) { should be_a Greeve::Rowset }

      it "includes specific events" do
        events = subject.event_attendees.map(&:event_id)

        event_ids.each do |id|
          events.should include id
        end
      end
    end

    context "event_attendees" do
      subject { resource.event_attendees.first }

      its(:event_id) { should eq 1450975 }
      its(:character_id) { should eq 1 }
      its(:character_name) { should eq "EVE System" }
      its(:response) { should eq "Accepted" }
    end
  end
end
