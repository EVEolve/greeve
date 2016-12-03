vcr_opts = {
  cassette_name: "character/contact_notifications",
}

describe Greeve::Character::ContactNotifications, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::ContactNotifications.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:contact_notifications) { should be_a Greeve::Rowset }
  end

  context "contact_notifications" do
    subject { resource.contact_notifications.first }

    its(:notification_id) { should eq 308734131 }
    its(:sender_id) { should eq 797400947 }
    its(:sender_name) { should eq "CCP Garthagk" }
    its(:sent_date) { should eq Time.parse("2010-05-29 23:04:00 UTC") }
    its(:message_data) { should eq({
      "level" => "10",
      "message" => "Hi, I want to social network with you!",
    }) }
  end
end
