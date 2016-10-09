vcr_opts = {
  cassette_name: "eve/character_info",
}

vcr_opts_match_any = {
  cassette_name: "eve/character_info",
  match_requests_on: [],
  allow_playback_repeats: true,
}

describe Greeve::BaseItem, vcr: vcr_opts do
  let(:character_id)  { 462421468 }
  let(:character_name) { "Zaphoon" }

  it "is an abstract class" do
    expect { Greeve::BaseItem.new(character_id) }.to raise_error(TypeError)
  end

  context "subclassed" do
    let(:subclass) {
      Class.new(Greeve::BaseItem).tap do |klass|
        klass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_id,     xpath: "eveapi/result/characterID/?[0]",     type: :integer
          attribute :character_name,   xpath: "eveapi/result/characterName/?[0]",   type: :string
          attribute :corporation_date, xpath: "eveapi/result/corporationDate/?[0]", type: :datetime
          attribute :security_status,  xpath: "eveapi/result/securityStatus/?[0]",  type: :numeric
          attribute :does_not_exist,   xpath: "does_not_exist/?[0]",                type: :string

          def initialize(character_id)
            super(query_params: {"characterID" => character_id})
          end
        end
      end
    }

    let(:api_item) { subclass.new(character_id) }
    subject { api_item }

    describe "DSL" do
      let(:subclass) {
        Class.new(Greeve::BaseItem).tap do |klass|
          klass.class_eval do
            def initialize(character_id)
              super(query_params: {"characterID" => character_id})
            end
          end
        end
      }

      specify "endpoint", vcr: vcr_opts_match_any do
        subclass.class_eval do
          endpoint "/test/endpoint.xml.aspx"
        end

        subject.__send__(:endpoint).should eq "test/endpoint"
      end

      specify "attribute" do
        _character_name_xpath = "eveapi/result/characterName/?[0]"

        subclass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_name, xpath: _character_name_xpath, type: :string
        end

        subject.character_name.should eq character_name
      end

      describe "rowset" do
        let(:rowset) { api_item.employment_history }
        subject { rowset }

        before {
          subclass.class_eval do
            endpoint "eve/CharacterInfo"

            rowset :employment_history, xpath: "eveapi/result/rowset[@name='employmentHistory']" do
              attribute :record_id,        xpath: "@recordID",        type: :integer
              attribute :corporation_id,   xpath: "@corporationID",   type: :integer
              attribute :corporation_name, xpath: "@corporationName", type: :string
              attribute :start_date,       xpath: "@startDate",       type: :datetime
            end
          end
        }

        it { should be_a Greeve::Rowset }
        its(:name) { should eq :employment_history }

        its(:to_a) do
          should eq [
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
          ]
        end
      end
    end

    describe "cache_expired?", vcr: vcr_opts_match_any do
      before {
        # Replace `cachedUntil` with a mocked value.
        subject.instance_variable_get(:@xml_element).tap do |xml|
          xml.locate("eveapi/cachedUntil").first.tap do |e|
            e.nodes.clear
            e << cached_until.to_s.gsub(/ UTC$/, "")
          end
        end
      }

      describe "returns true if cache time is in the past" do
        let(:cached_until) { (Time.now - 3600).utc }

        its(:cache_expired?) { should be true }
        its(:refresh) { should be true }
      end

      describe "returns false if cache time is in the future" do
        let(:cached_until) { (Time.now + 3600).utc }

        its(:cache_expired?) { should be false }
        its(:refresh) { should be false }
      end
    end

    its(:inspect) do
      should include subject.object_id.to_s
      should include "character_name: #{character_name}"
      should include "corporation_date: 2016-07-24 02:57:00 UTC"
      should include "security_status: 2.40297246280317"
    end

    its(:to_s) do
      should include "character_name: #{character_name}"
    end

    its(:to_h) do
      should eq({
        character_id: character_id,
        character_name: "Zaphoon",
        corporation_date: Time.parse("2016-07-24 02:57:00 UTC"),
        security_status: BigDecimal.new("2.40297246280317"),
      })
    end
  end
end
