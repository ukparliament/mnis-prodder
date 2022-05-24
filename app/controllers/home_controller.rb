# The code to assemble filter parameters, assemble include parameters and append to query parameters is packaged into separate modules.
# We require these modules to be loaded.
require "#{Rails.root}/lib/modules/assemble_filter_parameters"
require "#{Rails.root}/lib/modules/assemble_include_parameters"
require "#{Rails.root}/lib/modules/append_to_query_parameters"

# # Home controller.
# Handles the form and the conversion of parameters from the form into parameters for the public [MNIS API](https://data.parliament.uk/membersdataplatform/memberquery.aspx).
class HomeController < ApplicationController
  
  # We include code to assemble filter parameters, assemble include parameters and append to query parameters
  include ASSEMBLE_FILTER_PARAMETERS
  include ASSEMBLE_INCLUDE_PARAMETERS
  include APPEND_TO_QUERY_PARAMETERS
  
  # ## Method to display the filter form.
  def index
  end
  
  ## Method to display the lookup form.
  def lookup
  end
  
  # ## Method to parse the parameters from the form and convert to parameters for the public MNIS API.
  def form_parse
    
    # We assemble the filter parameters.
    @filter_parameters = assemble_filter_parameters
    
    # We assemble the include parameters.
    @include_parameters = assemble_include_parameters
    
    # We pass the API filter and include parameters we've constructed to the parse method. This method calls the public MNIS API with these parameters, parses the resulting XML and displays as HTML.
    redirect_to( "/parse?filter=#{@filter_parameters}&include=#{@include_parameters}" )
  end
end
