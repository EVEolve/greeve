vcr_opts = {
  cassette_name: "character/contact_list",
}

describe Greeve::Character::ContactList, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::ContactList.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:contact_list) { should be_a Greeve::Rowset }
    its(:contact_labels) { should be_a Greeve::Rowset }
    its(:corporate_contact_list) { should be_a Greeve::Rowset }
    its(:corporate_contact_labels) { should be_a Greeve::Rowset }
    its(:alliance_contact_list) { should be_a Greeve::Rowset }
    its(:alliance_contact_labels) { should be_a Greeve::Rowset }
  end

  context "contact_list" do
    subject { resource.contact_list.first }

    its(:contact_id) { should eq 92902265 }
    its(:contact_name) { should eq "Remy Hart" }
    its(:standing) { should eq 10 }
    its(:contact_type_id) { should eq 1379 }
    its(:label_mask) { should eq 1 }
    its(:in_watchlist) { should eq true }
  end

  context "contact_labels" do
    subject { resource.contact_labels.first }

    its(:label_id) { should eq 1 }
    its(:name) { should eq "Test Label" }
  end

  context "corporate_contact_list" do
    subject { resource.corporate_contact_list.first }

    its(:contact_id) { should eq 384667640 }
    its(:contact_name) { should eq "Black Frog Logistics" }
    its(:standing) { should eq 5 }
    its(:contact_type_id) { should eq 2 }
    its(:label_mask) { should eq 0 }
  end

  context "corporate_contact_labels" do
    subject { resource.corporate_contact_labels.first }

    it { should be nil }
  end

  context "alliance_contact_list" do
    subject { resource.alliance_contact_list.first }

    it { should be nil }
  end

  context "alliance_contact_labels" do
    subject { resource.alliance_contact_labels.first }

    it { should be nil }
  end
end
