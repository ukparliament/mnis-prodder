# The main XML parsing code is packaged into a separate module.

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
	
    # We get the public MNIS API URI using open-uri and convert to Nokogiri XML.
    doc = Nokogiri::XML( URI.open( @uri ) )
    
    # We call the parse_xml method in the parse_xml module to parse the XML returned from the public MNIS API.
    parse_xml( doc )
    
    # If the filter includes a specific Member ID ...
    if is_specific_member_filter?( filter )
    
      # ... we know we've looked up a single Member by an identifier.
      @page_title = 'Member'
      @description = 'A Member.'
      @crumb << { label: 'Lookup a Member', url: home_lookup_url }
      @crumb << { label: 'Member', url: nil }
      @section = 'lookup'
    
    # Otherwise, if the filter does not include a specific Member ID ...
    else
    
      # ... we know we've looked up a list of Members.
      @page_title = 'Members'
      @description = 'Members list.'
      @crumb << { label: 'Members', url: nil }
      @section = 'filter'
    end
  end
  
  
private
  def is_specific_member_filter?( filter )
    is_specific_member_filter = false
    is_specific_member_filter = true if filter.include?( 'id=' )
    is_specific_member_filter = true if filter.include?( 'refDods=' )
    is_specific_member_filter = true if filter.include?( 'refClerks=' )
    is_specific_member_filter = true if filter.include?( 'refPims=' )
    is_specific_member_filter = true if filter.include?( 'refRush=' )
    is_specific_member_filter = true if filter.include?( 'refCommonsEnq=' )
    is_specific_member_filter = true if filter.include?( 'refCommonsHansard=' )
    is_specific_member_filter
  end
end