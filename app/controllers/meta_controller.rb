class MetaController < ApplicationController

  def index
    @page_title = 'About this website'
      @crumb << { label: 'About this website', url: nil }
    @description = 'About this website'
  end

  def cookies
    @page_title = 'Cookies'
      @crumb << { label: 'About this website', url: meta_list_url }
      @crumb << { label: 'Cookies', url: nil }
    @description = 'Cookie policy'
  end
end
