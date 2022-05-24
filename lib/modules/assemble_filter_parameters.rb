# # Module to assemble filter parameters.
module ASSEMBLE_FILTER_PARAMETERS
  
  # ## Method to assemble the filter parameters.
  def assemble_filter_parameters
    
    # We create an empty string to hold the filter parameters we intend to pass to the public MNIS API.
    filter_parameters = ''
    
    # We get the filter parameters passed by the form filter form.
    filter_current_members = params[:filter_current_members]
    filter_left_days = params[:filter_left_days]
    filter_previous_house_members = params[:filter_previous_house_members]
    filter_house = params[:filter_house]
    filter_eligible = params[:filter_eligible]
    filter_previous_party_affiliation = params[:filter_previous_party_affiliation]
    filter_party_id = params[:filter_party_id]
    filter_gender = params[:filter_gender]
    filter_government_position_held = params[:filter_government_position_held]
    filter_opposition_position_held = params[:filter_opposition_position_held]
    filter_parliamentary_position_held = params[:filter_parliamentary_position_held]
    filter_election_type = params[:filter_election_type]
    filter_general_election_year = params[:filter_general_election_year]
    filter_by_election_date = params[:filter_by_election_date]
    filter_nuts_region = params[:filter_nuts_region]
    
    # We get the filter parameteters passed by the lookup form.
    filter_identifier = params[:identifier]
    filter_identifier_source = params[:identifier_source]
    
    # ### We lookup by identifier.
    # If the lookup form has passed an identifier and the identifier is populated ....
    if filter_identifier and !filter_identifier.blank?
      
      # ... we set the filter parameters to return a Member with a given identifier from a given identifier source.
      filter_parameters = append_to_query_parameters( filter_parameters, "#{filter_identifier_source}=#{filter_identifier}", '=' )
    end
    
    # #### We filter for current Members or 'all' Members.
    # If the current members only checkbox is not checked ...
    if filter_current_members != 'true'
      
      # ... we set the filter parameters to return all Members.
      filter_parameters = append_to_query_parameters( filter_parameters, 'membership=all', '=' )
    end
    
    # #### We filter for Members having left in the last X days.
    # If the filter left days box is populated ...
    unless filter_left_days.blank?
      
      # ... we set the filter parameters to only return Members who have left in the last X days.
      filter_parameters = append_to_query_parameters( filter_parameters, "leftdays=#{filter_left_days}", '=' )
    end
    
    # #### We filter for gender.
    # If the female radio button is selected ...
    if filter_gender == '1'
      
      # ... we set the filter parameters to return only female Members.
      filter_parameters = append_to_query_parameters( filter_parameters, 'gender=F', '=' )
    
    # If the male radio button is selected ...
    elsif filter_gender == '2'
      
      # ... we set the filter parameters to return only male Members.
      filter_parameters = append_to_query_parameters( filter_parameters, 'gender=M', '=' )
    end
    
    # Otherwise, if the all genders radio button is selected, we do nothing.
    
    # #### We filter for House membership.
    # If the previous House Members checkbox is checked ...
    if filter_previous_house_members == 'true'
      
      # ... we set the separator to an asterix.
      separator = '*'
    
    # Otherwise, if the previous House Members checkbox is not checked ...
    else 
      
      # ... we set the separator to an equals.
      separator = '='
    end
    
    # If the House of Commons radio button is selected ...
    if filter_house == '1'
      
      # ... we set the filter parameters to return only House of Commons Members.
      filter_parameters = append_to_query_parameters( filter_parameters, 'house=commons', separator )
      
    # Otherwise, if the House of Lords radio button is selected ...
    elsif filter_house == '2'
      
      # ... we set the filter parameters to return only House of Lords Members.
      filter_parameters = append_to_query_parameters( filter_parameters, 'house=lords', separator )
      
    # Otherwise, if the both Houses radio button is selected ...
    else
      
      # ... we set the filter parameters to return Members of both Houses.
      filter_parameters = append_to_query_parameters( filter_parameters, 'house=both', separator )
    end
    
    # #### We filter for eligibility to sit.
    # If the is eligible radio button is selected ...
    if filter_eligible == '1'
      
      # ... we set the filter parameters to only return Members being eligible to sit.
      filter_parameters = append_to_query_parameters( filter_parameters, "iseligible=true", '=' )
    
    # Otherwise, if the not eligible radio button is selected ...
    elsif filter_eligible == '2'
      
      # ... we set the filter parameters to only return Members not being eligible to sit.
      filter_parameters = append_to_query_parameters( filter_parameters, "iseligible=false", '=' )
    end
    
    # #### We filter for party affiliation.
    # If the previous party affilation checkbox is checked ...
    if filter_previous_party_affiliation == 'true'
      
      # ... we set the separator to an asterix.
      separator = '*'
    
    # Otherwise, if the previous party affilation checkbox is not checked ...
    else 
      
      # ... we set the separator to an equals.
      separator = '='
    end
    
    # If the party ID has been passed by the form and the select is not set to 'All' ...
    if filter_party_id and filter_party_id != 'all'
      
      # ... we set the filter parameters to return only Members affiliated with the selected party.
      filter_parameters = append_to_query_parameters( filter_parameters, "partyid=#{filter_party_id}", separator )
    end
    
    # #### We filter for incumbency in government position.
    # If the held Government position radio button is selected ...
    if filter_government_position_held == '1'
      
      # ... we set the filter parameters to only return Members holding Government positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsgovernmentpost=true", '=' )
    
    # Otherwise, if the does not hold Government position radio button is selected ...
    elsif filter_government_position_held == '2'
      
      # ... we set the filter parameters to only return Members not holding Government positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsgovernmentpost=false", '=' )
    end
    
    # #### We filter for incumbency in opposition position.
    # If the held Opposition position radio button is selected ...
    if filter_opposition_position_held == '1'
      
      # ... we set the filter parameters to only return Members holding Opposition positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsoppositionpost=true", '=' )
    
    # Otherwise, if the does not hold Opposition position radio button is selected ...
    elsif filter_opposition_position_held == '2'
      
      # ... we set the filter parameters to only return Members not holding Opposition positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsoppositionpost=false", '=' )
    end
    
    # #### We filter for incumbency in parliamentary position.
    # If the held parliamentary position radio button is selected ...
    if filter_parliamentary_position_held == '1'
      
      # ... we set the filter parameters to only return Members holding parliamentary positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsparliamentarypost=true", '=' )
    
    # Otherwise, if the does not hold parliamentary position radio button is selected ...
    elsif filter_parliamentary_position_held == '2'
      
      # ... we set the filter parameters to only return Members not holding parliamentary positions.
      filter_parameters = append_to_query_parameters( filter_parameters, "holdsparliamentarypost=false", '=' )
    end
    
    # ### We filter for Members returned at an election.
    # If the filter election type has the general election radio button selected ...
    if filter_election_type == '1'
      
      # ... if the general election year box is populated ...
      unless filter_general_election_year.blank?
        
        # ... we set the filter parameters to return Members returned at a given general election.
        filter_parameters = append_to_query_parameters( filter_parameters, "returnedatelection=#{filter_general_election_year} general election", '=' )
      end
    end
    # If the filter election type has the by-election radio button selected ...
    if filter_election_type == '2'
      
      # ... if the by election date box is populated ...
      unless filter_by_election_date.blank?
        
        # ... we set the by-election date in the format expected (11-Apr-1972) ...
        by_election_date = filter_by_election_date.to_date.strftime( '%d-%b-%Y' )
        
        # ... and set the filter parameters to return Members returned at a given by election.
        filter_parameters = append_to_query_parameters( filter_parameters, "returnedatelection=#{by_election_date} by-election", '=' )
      end
    end
    
    # ### We filter for Members in a constituency in a NUTS region.
    # If the NUTS region has been passed by the form and the select is not set to 'All' ...
    if filter_nuts_region and filter_nuts_region != 'all'
    
      # ... we set the filter parameters to return only Members in a constituency in the selected area.
      filter_parameters = append_to_query_parameters( filter_parameters, "constituencyinarea=#{filter_nuts_region}", separator )
    end
    
    # We return the filter parameters.
    filter_parameters
  end
end