module Greeve
  module Handlers
    # YARD handler for the `rowset` DSL method.
    class Rowset < YARD::Handlers::Ruby::Base
      handles method_call(:rowset)
      namespace_only

      process do
        name = statement.parameters[0].jump(:ident).source
        block_ast = statement.last.last

        object = YARD::CodeObjects::MethodObject.new(namespace, name)
        register(object)
        parse_block(block_ast, owner: object)

        object.group = "Attributes"

        object.add_tag(YARD::Tags::Tag.new(:return, nil, "Greeve::Rowset"))

        block_ast.each do |node|
          method_name = node.first.jump(:ident).source

          next unless method_name == "attribute"

          attribute_name = node.parameters[0].jump(:ident).source

          type =
            node
              .parameters[1]
              .jump(:assoc, :label, "type")
              .parent
              .jump(:ident)
              .source

          attribute_type =
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

          object.add_tag(
            YARD::Tags::Tag.new(:param, nil, attribute_type, attribute_name)
          )
        end
      end
    end
  end
end
