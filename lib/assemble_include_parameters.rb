# # Module to assemble include parameters.
module AssembleIncludeParameters
  
  # ## Method to assemble the include parameters.
  def assemble_include_parameters
    
    # We create an empty string to hold the include parameters we intend to pass to the public MNIS API.
    include_parameters = ''
    
    # We get the include parameters passed by the form.
    include_maiden_speeches = params[:include_maiden_speeches]
    include_addresses = params[:include_addresses]
    include_constituencies = params[:include_constituencies]
    include_parties = params[:include_parties]
    include_basic_details = params[:include_basic_details]
    
    # #### We include maiden speeches if requested.
    # If the include maiden speeches checkbox is checked ...
    if include_maiden_speeches == 'true'
      
      # ... we set the include parameters to return maiden speeches.
      include_parameters = append_to_query_parameters( include_parameters, 'maidenspeeches', '' )
    end
    
    # #### We include addresses if requested.
    # If the include addresses checkbox is checked ...
    if include_addresses == 'true'
      
      # ... we set the include parameters to return addresses.
      include_parameters = append_to_query_parameters( include_parameters, 'addresses', '' )
    end
    
    # #### We include constituencies if requested.
    # If the include constituencies checkbox is checked ...
    if include_constituencies == 'true'
      
      # ... we set the include parameters to return constituencies.
      include_parameters = append_to_query_parameters( include_parameters, 'constituencies', '' )
    end
    
    # #### We include parties if requested.
    # If the include parties checkbox is checked ...
    if include_parties == 'true'
      
      # ... we set the include parameters to return parties.
      include_parameters = append_to_query_parameters( include_parameters, 'parties', '' )
    end
    
    # #### We include basic details if requested.
    # If the include basic details checkbox is checked ...
    if include_basic_details == 'true'
      
      # ... we set the include parameters to return basic details.
      include_parameters = append_to_query_parameters( include_parameters, 'basicdetails', '' )
    end

    # We return the include parameters.
    include_parameters
  end
end