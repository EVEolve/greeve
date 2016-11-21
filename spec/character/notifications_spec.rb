vcr_opts = {
  cassette_name: "character/notifications",
}

describe Greeve::Character::Notifications, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Notifications.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:notifications) { should be_a Greeve::Rowset }
  end

  context "notifications" do
    subject { resource.notifications.first }

    its(:notification_id) { should eq 589251502 }
    its(:type_id) { should eq 10 }
    its(:sender_id) { should eq 1000033 }
    its(:sender_name) { should eq "Caldari Business Tribunal" }
    its(:sent_date) { should eq Time.parse("2016-11-21 03:57:00 UTC") }
    its(:read) { should eq false }
  end
end
