class ApplicationController < ActionController::Base

  include LibraryDesign::Crumbs

  $SITE_TITLE = 'MNIS Prodder'
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )
end
