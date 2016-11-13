describe Greeve::Helpers::AttributeToHash do
  subject {
    Class.new do
      include Greeve::Helpers::AttributeToHash

      def foo; 2 end
      def bar; "it works" end
      def baz; BigDecimal.new("3.14") end

      private

      def _attributes
        {
          foo: {},
          bar: {},
          baz: {},
        }
      end
    end.new
  }

  its(:to_h) do
    should eq ({
      foo: 2,
      bar: "it works",
      baz: 3.14,
    })
  end
end
