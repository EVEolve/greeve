describe Greeve::Row do
  let(:xml_element) {
    load_xml_file("eve/character_info")
      .locate("eveapi/result/rowset/?[0]")
      .first
  }

  let(:attributes) {{
    record_id:        {xpath: "@recordID",        type: :integer},
    corporation_id:   {xpath: "@corporationID",   type: :integer},
    corporation_name: {xpath: "@corporationName", type: :string},
    start_date:       {xpath: "@startDate",       type: :datetime},
  }}

  let(:row) { Greeve::Row.new(xml_element, attributes) }

  subject { row }

  its(:to_h) {
    should eq({
      record_id: 42416328,
      corporation_id: 98063277,
      corporation_name: "Archon Corporation",
      start_date: Time.parse("2016-07-24 02:57:00 UTC"),
    })
  }

  describe "to_s" do
    subject { row.to_s }

    specify do
      subject.should include "record_id: 42416328"
      subject.should include "corporation_id: 98063277"
      subject.should include "corporation_name: Archon Corporation"
      subject.should include "start_date: 2016-07-24 02:57:00 UTC"
    end
  end

  describe "inspect" do
    subject { row.inspect }

    specify do
      subject.should include "record_id: 42416328"
      subject.should include "corporation_id: 98063277"
      subject.should include "corporation_name: Archon Corporation"
      subject.should include "start_date: 2016-07-24 02:57:00 UTC"
    end
  end
end
