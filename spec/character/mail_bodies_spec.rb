vcr_opts = {
  cassette_name: "character/mail_bodies",
}

vcr_opts_multiple_ids = {
  cassette_name: "character/mail_bodies_multiple_ids",
}

describe Greeve::Character::MailBodies, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }
  let(:message_ids) { 362680744 }

  let(:resource) {
    Greeve::Character::MailBodies.new(character_id, message_ids, key: key, vcode: vcode)
  }

  context "single message id" do
    context "resource" do
      subject { resource }

      its(:messages) { should be_a Greeve::Rowset }
    end

    context "messages" do
      subject { resource.messages.first }

      its(:message_id) { should eq 362680744 }
      its(:message_text) { should eq "Second test message." }
    end
  end

  context "multiple message ids", vcr: vcr_opts_multiple_ids do
    let(:message_ids) { [362680073, 362680744] }

    context "resource" do
      subject { resource }

      its(:messages) { should be_a Greeve::Rowset }

      it "includes specific messages" do
        messages = subject.messages.map(&:message_id)

        message_ids.each do |id|
          messages.should include id
        end
      end
    end

    context "messages" do
      subject { resource.messages.first }

      its(:message_id) { should eq 362680073 }
      its(:message_text) { should eq "API test" }
    end
  end
end
