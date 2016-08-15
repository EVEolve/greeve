require "ox"

# Spec helpers for working with XML.
module XMLHelpers

  # Parse a file located in spec/xml into an XML element.
  #
  # @param file_name [String] base name of the file (the .xml extension does not
  #   need to be specified)
  #
  # @option opts [String] :xpath (nil) optional xpath of a nested element to
  #   return. The root element is returned if this is not specified.
  #
  # @return [Ox::Element] an XML element
  def load_xml_file(file_name, opts = {})
    xpath = opts[:xpath]

    file_name.gsub!(/\.xml$/, "")
    element = Ox.parse(File.open("spec/xml/#{file_name}.xml").read)

    xpath ? element.locate(xpath).first : element
  end

end
