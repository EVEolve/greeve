describe Greeve::BaseItem do
  let(:response_file) { "public_character_info" }
  let(:character_id)  { 462421468 }
  let(:character_name) { "Zaphoon" }

  before {
    stub_endpoint(
      "#{Greeve::EVE_API_BASE_URL}/eve/CharacterInfo.xml.aspx?characterID=#{character_id}",
      response_file
    )

    stub_endpoint(
      %r{#{Greeve::EVE_API_BASE_URL}/test/endpoint.xml.aspx},
      response_file
    )

    invalidate_remaining_endpoints
  }

  it "is an abstract class" do
    expect { Greeve::BaseItem.new(character_id) }.to raise_error(TypeError)
  end

  context "subclassed" do
    let(:subclass) {
      Class.new(Greeve::BaseItem).tap do |klass|
        klass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_id,    xpath: "eveapi/result/characterID/?[0]",    type: :integer
          attribute :character_name,  xpath: "eveapi/result/characterName/?[0]",  type: :string
          attribute :security_status, xpath: "eveapi/result/securityStatus/?[0]", type: :numeric

          def initialize(character_id)
            super(query_params: {"characterID" => character_id})
          end
        end
      end
    }

    subject { subclass.new(character_id) }

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

      specify "endpoint" do
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
    end

    describe "cache_expired?" do
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
    end

    its(:to_s) do
      should include "character_name: #{character_name}"
    end
  end
end
