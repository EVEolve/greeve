describe Greeve::Helpers::DefineDSLMethods do
  let(:xml_double) {
    double.tap do |d|
      allow(d).to receive(:locate) { [value] }
    end
  }

  let(:instance) { klass.new(xml_double) }
  let(:attribute_name) { :foo }

  subject { instance.send(attribute_name) }

  context "define_attribute_method" do
    shared_examples :test_attribute_types do
      describe "integer attribute" do
        let(:value) { "3" }
        let(:expected) { 3 }

        include_examples :can_define_an_attribute, :integer, Fixnum
      end

      describe "integer_array attribute" do
        let(:value) { "3,6,9" }
        let(:expected) { [3, 6, 9] }

        include_examples :can_define_an_attribute, :integer_array, Array
      end

      describe "numeric attribute" do
        let(:value) { "3.1" }
        let(:expected) { BigDecimal.new("3.1") }

        include_examples :can_define_an_attribute, :numeric, BigDecimal
      end

      describe "boolean attribute" do
        describe "true" do
          let(:value) { "True" }
          let(:expected) { true }

          include_examples :can_define_an_attribute, :boolean, TrueClass
        end

        describe "false" do
          let(:value) { "False" }
          let(:expected) { false }

          include_examples :can_define_an_attribute, :boolean, FalseClass
        end

        describe "1" do
          let(:value) { "1" }
          let(:expected) { true }

          include_examples :can_define_an_attribute, :boolean, TrueClass
        end

        describe "0" do
          let(:value) { "0" }
          let(:expected) { false }

          include_examples :can_define_an_attribute, :boolean, FalseClass
        end
      end

      describe "string attribute" do
        let(:value) { "3" }
        let(:expected) { "3" }

        include_examples :can_define_an_attribute, :string, String

        describe "strips leading and trailing whitespace" do
          let(:value) { "\ttest\n" }
          let(:expected) { "test" }

          include_examples :can_define_an_attribute, :string, String
        end
      end

      describe "datetime attribute" do
        let(:value) { "2016-07-24 02:57:00" }
        let(:expected) { Time.parse("2016-07-24 02:57:00 UTC") }

        include_examples :can_define_an_attribute, :datetime, Time

        context "is empty" do
          let(:value) { "" }
          let(:expected) { nil }

          include_examples :can_define_an_attribute, :datetime, NilClass
        end
      end
    end

    context "class" do
      let(:klass) {
        Class.new do
          extend Greeve::Helpers::DefineDSLMethods

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
          include Greeve::Helpers::DefineDSLMethods

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

  context "define_namespace_method" do
    # Unused for namespace, but easier to specify for reusable tests.
    let(:value) { nil }

    context "class" do
      let(:klass) {
        Class.new do
          extend Greeve::Helpers::DefineDSLMethods

          def self.namespace(name, opts = {}, &block)
            define_namespace_method(:class, name, opts, &block)
          end

          def initialize(xml_element)
            @xml_element = xml_element
          end
        end
      }

      specify do
        _attribute_name = attribute_name

        klass.instance_eval do
          namespace _attribute_name, xpath: "testPath" do
          end
        end

        subject.should be_a Greeve::Namespace
        subject.name.should eq attribute_name
      end
    end

    context "instance" do
      let(:klass) {
        Class.new do
          include Greeve::Helpers::DefineDSLMethods

          def namespace(name, opts = {}, &block)
            define_namespace_method(:instance, name, opts, &block)
          end

          def initialize(xml_element)
            @xml_element = xml_element
          end
        end
      }

      specify do
        _attribute_name = attribute_name

        instance.instance_eval do
          namespace _attribute_name, xpath: "testPath" do
          end
        end

        subject.should be_a Greeve::Namespace
        subject.name.should eq attribute_name
      end
    end
  end
end
