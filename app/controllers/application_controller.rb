class ApplicationController < ActionController::Base

  include LibraryDesign::Crumbs

  $SITE_TITLE = 'MNIS Prodder'
end
