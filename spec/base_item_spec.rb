describe Greeve::BaseItem do
  let(:response_file) { "public_character_info" }
  let(:character_xml) { load_xml_file(response_file) }
  let(:character_id)  { 462421468 }

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
    expect { Greeve::BaseItem.new(character_xml) }.to raise_error(TypeError)
  end

  context "subclassed" do
    let(:subclass) {
      Class.new(Greeve::BaseItem).tap do |klass|
        klass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_id, xpath: "eveapi/result/characterID/?[0]", type: :integer
          attribute :character_name, xpath: "eveapi/result/characterName/?[0]", type: :string
          attribute :security_status, xpath: "eveapi/result/securityStatus/?[0]", type: :numeric

          def initialize(character_id)
            super(query_params: {"characterID" => character_id})
          end
        end
      end
    }

    let(:character_name_xpath) { "eveapi/result/characterName/?[0]" }
    let(:character_name) { character_xml.locate(character_name_xpath).first }

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
        _character_name_xpath = character_name_xpath

        subclass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_name, xpath: _character_name_xpath, type: :string
        end

        subject.character_name.should eq character_name
      end  
    end

    specify "refresh"
    specify "cache_expired?"

    its(:inspect) do
      should include subject.object_id.to_s
      should include "character_name: #{character_name}"
    end

    its(:to_s) do
      should include "character_name: #{character_name}"
    end
  end
end
