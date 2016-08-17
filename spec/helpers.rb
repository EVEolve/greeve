require "ox"

# Spec helpers for working with XML.
module SpecHelpers
  # Stub out an HTTP endpoint to return a canned response.
  #
  # @param endpoint [String, Regexp] full URL of the endpoint to stub
  # @param response_file [String] base name of the file to load as a response
  #   (the .xml extension does not need to be specified)
  #
  # @option opts [Integer] :code (200) HTTP response code to return
  def stub_endpoint(endpoint, response_file, opts = {})
    code = opts[:code] || 200

    Typhoeus
      .stub(endpoint)
      .and_return(
        Typhoeus::Response.new(code: code, body:  load_file(response_file))
      )
  end

  # Stub out the remaining HTTP endpoints with 500 errors so that live HTTP
  # requests aren't sent.
  def invalidate_remaining_endpoints
    Typhoeus
      .stub(/.*/)
      .and_return(Typhoeus::Response.new(code: 500))
  end

  # Load an XML file as a string.
  #
  # @param file_name [String] base name of the file (the .xml extension does not
  #   need to be specified)
  #
  # @return [String] stringified XML file
  def load_file(file_name)
    _file_name = file_name.gsub(/\.xml$/, "")
    File.open("spec/xml/#{_file_name}.xml").read
  end

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

    element = Ox.parse(load_file(file_name))

    xpath ? element.locate(xpath).first : element
  end
end
