module Greeve
  module Handlers
    # YARD handler for the `attribute` DSL method.
    class Attribute < YARD::Handlers::Ruby::Base
      handles method_call(:attribute)
      namespace_only

      process do
        name = statement.parameters[0].jump(:ident).source

        type =
          statement
            .parameters[1]
            .jump(:assoc, :label, "type")
            .parent
            .jump(:ident)
            .source

        object = YARD::CodeObjects::MethodObject.new(namespace, name)
        register(object)

        object.group = "Attributes"

        return_type =
          case type
          when "integer"
            type.capitalize
          when "string"
            type.capitalize
          when "numeric"
            "BigDecimal"
          when "datetime"
            "Time"
          end

        object.add_tag(YARD::Tags::Tag.new(:return, nil, return_type))
      end
    end
  end
end
