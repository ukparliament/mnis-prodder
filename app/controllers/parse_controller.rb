# The main XML parsing code is packaged into a separate module.
# We require the main XML parsing code to be loaded.

# We require open-uri to get the response from the public MNIS API.
require 'open-uri'

# We require Nokogiri to parse the XML returned from the public MNIS API
require 'nokogiri'

# # Parse controller.
class ParseController < ApplicationController
  
  # We include code for the main XML parsing rules.
  include ParseXML

  # ## A method to get data from the public MNIS API and parse the XML reponse.
  def parse
    
    # We create an array to hold the data for each Member.
    @members = []
    
    # We get the filter parameter passed to this method.
    # The filter parameter is used to determine the record set of Member results returned.
    filter = params[:filter]
    
    # We get the include parameter passed to this method.
    # The include parameter is used to specify any additional data we want to return for each Member in the record set.
    include = params[:include]
    
    # We construct the public MNIS API URI with filters and includes set.
    
    uri_parser = URI::Parser.new

	@uri = uri_parser.escape( "https://data.parliament.uk/membersdataplatform/services/mnis/members/query/#{filter}/#{include}/" )
	
#     @uri = URI::encode( "https://data.parliament.uk/membersdataplatform/services/mnis/members/query/#{filter}/#{include}/" )

    @uri_fold = "https://data.parliament.uk/membersdataplatform/services/mnis/members/query/#{filter}/#{include}/".gsub('/', '/<wbr>')

    # We get the public MNIS API URI using open-uri and convert to Nokogiri XML.
    doc = Nokogiri::XML( URI.open( @uri ) )
    
    # We call the parse_xml method in the parse_xml module to parse the XML returned from the public MNIS API.
    parse_xml( doc )
  end
end