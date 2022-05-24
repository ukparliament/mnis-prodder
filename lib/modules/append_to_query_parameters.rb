# # Module to append to query parameters.
module APPEND_TO_QUERY_PARAMETERS
  
  # ## Method to append additional query parameters.
  # This method takes a query parameter as constructed. This may be a set of filter parameters or a set of inclusion parameters.
  # It also takes the parameter to append and the type of separator if any. For filter parameters, this is either an equals where only Members currently matching the criteria are included, or an asterix returning Members who once matched the criteria.
  def append_to_query_parameters( query_parameters, append, separator )
    
    # Add a pipe to separate parameters if the query parameters are already populated, .
    query_parameters += "|" if !query_parameters.blank?
    
    # Replace the equals with an asterix if the separator is an asterix.
    append.gsub!( '=', '*' ) if separator == '*'
    
    # Return the query parameters as appended.
    query_parameters += append
  end
end