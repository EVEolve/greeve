vcr_opts = {
  cassette_name: "character/mailing_lists",
}

describe Greeve::Character::MailingLists, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::MailingLists.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:mailing_lists) { should be_a Greeve::Rowset }
  end

  context "mailing_lists" do
    subject { resource.mailing_lists.first }

    its(:list_id) { should eq 123456789 }
    its(:display_name) { should eq "Test List" }
  end
end
