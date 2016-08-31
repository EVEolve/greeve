describe Greeve::Helpers::DefineAttributeMethod do
  let(:xml_double) {
    double.tap do |d|
      allow(d).to receive(:locate) { [value] }
    end
  }

  let(:instance) { klass.new(xml_double) }
  let(:attribute_name) { :foo }

  subject { instance.send(attribute_name) }

  shared_examples :test_attribute_types do
    describe "integer attribute" do
      let(:value) { "3" }
      let(:expected) { 3 }

      include_examples :can_define_an_attribute, :integer, Fixnum
    end

    describe "numeric attribute" do
      let(:value) { "3.1" }
      let(:expected) { BigDecimal.new("3.1") }

      include_examples :can_define_an_attribute, :numeric, BigDecimal
    end

    describe "string attribute" do
      let(:value) { "3" }
      let(:expected) { "3" }

      include_examples :can_define_an_attribute, :string, String
    end

    describe "datetime attribute" do
      let(:value) { "2016-07-24 02:57:00" }
      let(:expected) { Time.parse("2016-07-24 02:57:00 UTC") }

      include_examples :can_define_an_attribute, :datetime, Time
    end
  end

  context "class" do
    let(:klass) {
      Class.new do
        extend Greeve::Helpers::DefineAttributeMethod

        def self.attribute(name, opts = {})
          define_attribute_method(:class, name, opts)
        end

        def initialize(xml_element)
          @xml_element = xml_element
        end
      end
    }

    shared_examples :can_define_an_attribute do |attribute_type, attribute_class|
      describe "can define an attribute of type #{attribute_type}" do
        specify do
          _attribute_name = attribute_name
          _attribute_type = attribute_type

          klass.instance_eval do
            attribute _attribute_name, xpath: "testPath", type: _attribute_type
          end

          subject.should be_a attribute_class
          subject.should eq expected
        end
      end
    end

    include_examples :test_attribute_types
  end

  context "instance" do
    let(:klass) {
      Class.new do
        include Greeve::Helpers::DefineAttributeMethod

        def attribute(name, opts = {})
          define_attribute_method(:instance, name, opts)
        end

        def initialize(xml_element)
          @xml_element = xml_element
        end
      end
    }

    shared_examples :can_define_an_attribute do |attribute_type, attribute_class|
      describe "can define an attribute of type #{attribute_type}" do
        specify do
          _attribute_name = attribute_name
          _attribute_type = attribute_type

          instance.instance_eval do
            attribute _attribute_name, xpath: "testPath", type: _attribute_type
          end

          subject.should be_a attribute_class
          subject.should eq expected
        end
      end
    end

    include_examples :test_attribute_types
  end
end
