class ApplicationController < ActionController::Base
	before_action do
    create_crumb_container
  end

  $SITE_TITLE = 'MNIS Prodder'

  private

   def create_crumb_container
    @crumb = []
  end
end
