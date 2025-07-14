# The code to assemble filter parameters, assemble include parameters and append to query parameters is packaged into separate modules.

# # Home controller.
# Handles the form and the conversion of parameters from the form into parameters for the public [MNIS API](https://data.parliament.uk/membersdataplatform/memberquery.aspx).
class HomeController < ApplicationController
  
  # We include code to assemble filter parameters, assemble include parameters and append to query parameters
  include AssembleFilterParameters
  include AssembleIncludeParameters
  include AppendToQueryParameters
  
  # ## Method to display the filter form.
  def index
    @page_title = 'Filter results'
    @description = 'Get a list of Members from MNIS'
    @section = 'filter'
  end
  
  ## Method to display the lookup form.
  def lookup
    @page_title = 'Lookup a Member'
    @description = 'Lookup a Member from MNIS'
    @crumb << { label: 'Lookup a Member', url: nil }
    @section = 'lookup'
  end
  
  # ## Method to parse the parameters from the form and convert to parameters for the public MNIS API.
  def form_parse
    
    # We assemble the filter parameters.
    @filter_parameters = assemble_filter_parameters
    
    # We assemble the include parameters.
    @include_parameters = assemble_include_parameters
    
    # We pass the API filter and include parameters we've constructed to the parse method. This method calls the public MNIS API with these parameters, parses the resulting XML and displays as HTML.
    redirect_to( "/mnis-prodder/parse?filter=#{@filter_parameters}&include=#{@include_parameters}" )
  end
end
