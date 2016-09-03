describe Greeve::Helpers::AddAttribute do
  subject {
    Class.new do
      extend Greeve::Helpers::AddAttribute

      public_class_method :add_attribute

      def self.attribute(name, opts = {})
        @attributes ||= {}

        add_attribute(name, opts)
      end

      def self.attributes
        @attributes
      end
    end
  }

  it "can add an attribute to a class" do
    subject.class_eval do
      attribute :foo, xpath: "bar", type: :baz
    end

    expected_attributes = {
      foo: {xpath: "bar", type: :baz}
    }

    subject.attributes.should eq expected_attributes
  end

  it "raises an error if an attribute is defined more than once" do
    expect {
      subject.class_eval do
        attribute :foo, xpath: "bar", type: :baz
        attribute :foo, xpath: "bar", type: :baz
      end
    }.to raise_error(RuntimeError, /defined more than once/)
  end

  it "raises an error if the xpath is not specified" do
    expect {
      subject.class_eval do
        attribute :foo, type: :baz
      end
    }.to raise_error(RuntimeError, /xpath(?:.*?)not specified/)
  end
end
