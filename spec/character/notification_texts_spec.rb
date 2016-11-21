vcr_opts = {
  cassette_name: "character/notification_texts",
}

describe Greeve::Character::NotificationTexts, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:ids) { 589251502 }

  let(:resource) {
    Greeve::Character::NotificationTexts.new(character_id, ids, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:notifications) { should be_a Greeve::Rowset }
  end

  context "notifications" do
    subject { resource.notifications.first }

    its(:notification_id) { should eq 589251502 }
    its(:notification_text) { should eq 589251502 }
  end
end
