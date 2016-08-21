describe Greeve::Rowset do
  let(:xml_element) {
    load_xml_file("public_character_info")
      .locate("eveapi/result/rowset")
      .first
  }

  let(:rowset_block) {
    proc {
      attribute :record_id,        xpath: "@recordID",        type: :integer
      attribute :corporation_id,   xpath: "@corporationID",   type: :integer
      attribute :corporation_name, xpath: "@corporationName", type: :string
      attribute :start_date,       xpath: "@startDate",       type: :datetime
    }
  }

  let(:rowset_name) { :employment_history }
  let(:rowset) { Greeve::Rowset.new(rowset_name, xml_element, &rowset_block) }

  subject { rowset }

  it { should be_an Enumerable }
  its(:each) { should be_an Enumerator }

  specify "attribute helper method is disabled after initialization" do
    expect { subject.attribute }.to raise_error NoMethodError
  end

  its(:to_a) { should eq [
    {
      record_id: 42416328,
      corporation_id: 98063277,
      corporation_name: "Archon Corporation",
      start_date: Time.parse("2016-07-24 02:57:00 UTC"),
    },
    {
      record_id: 34716213,
      corporation_id: 1000009,
      corporation_name: "Caldari Provisions",
      start_date: Time.parse("2014-08-25 00:54:00 UTC"),
    },
  ]}

  describe "inspect" do
    subject { rowset.inspect }

    specify do
      subject.should include rowset.class.to_s
      subject.should include rowset.object_id.to_s
      subject.should include "name: #{rowset_name}"
    end
  end
end
