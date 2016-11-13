vcr_opts = {
  cassette_name: "character/mail_messages",
}

describe Greeve::Character::MailMessages, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::MailMessages.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:messages) { should be_a Greeve::Rowset }
  end

  context "messages" do
    subject { resource.messages.first }

    its(:message_id) { should eq 362680073 }
    its(:sender_id) { should eq 462421468 }
    its(:sender_name) { should eq "Zaphoon" }
    its(:sent_date) { should eq Time.parse("2016-11-13 21:01:00 UTC") }
    its(:title) { should eq "Test Message" }
    its(:to_corp_or_alliance_id) { should eq 0 }
    its(:to_character_ids) { should eq [462421468] }
    its(:to_list_id) { should eq 0 }
  end
end
