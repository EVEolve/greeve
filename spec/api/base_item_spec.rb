describe Greeve::API::BaseItem do
  let(:character_xml) {
    load_xml_file("public_character_info", xpath: "result")
  }

  it "is an abstract class" do
    expect { Greeve::API::BaseItem.new(character_xml) }.to raise_error(TypeError)
  end

  context "subclassed" do
    let(:subclass) {
      Class.new(Greeve::API::BaseItem).tap do |klass|
        klass.class_eval do
          attribute :character_id,    xpath: "characterID/?[0]",    type: :integer
          attribute :character_name,  xpath: "characterName/?[0]",  type: :string
          attribute :security_status, xpath: "securityStatus/?[0]", type: :numeric
        end
      end
    }

    let(:character_name_xpath) { "characterName/?[0]" }
    let(:character_name) { character_xml.locate(character_name_xpath).first }

    subject { subclass.new(character_xml) }

    describe "class attributes" do
      let(:subclass) { Class.new(Greeve::API::BaseItem) }

      specify "can be defined" do
        _character_name_xpath = character_name_xpath

        subclass.class_eval do
          attribute :character_name, xpath: _character_name_xpath, type: :string
        end

        subject.character_name.should eq character_name
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
