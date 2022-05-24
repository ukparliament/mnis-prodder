class Member
  
  # Core data properties.
  attr_accessor :mnis_id
  attr_accessor :dods_id
  attr_accessor :pims_id
  attr_accessor :clerks_id
  attr_accessor :display_as
  attr_accessor :list_as
  attr_accessor :full_title
  attr_accessor :laying_minister_name
  attr_accessor :date_of_death
  attr_accessor :gender
  attr_accessor :party
  attr_accessor :house
  attr_accessor :constituency
  attr_accessor :lords_membership_type
  attr_accessor :house_start_date
  attr_accessor :house_end_date
  attr_accessor :membership_status_active
  attr_accessor :membership_status_text
  attr_accessor :membership_status_start_date
  attr_accessor :membership_status_reason
  
  # Included properties.
  attr_accessor :maiden_speeches
  attr_accessor :addresses
  attr_accessor :constituencies
  attr_accessor :parties
  
  # Basic details
  attr_accessor :given_surname
  attr_accessor :given_middle_names
  attr_accessor :given_forename
  attr_accessor :town_of_birth
  attr_accessor :country_of_birth
  attr_accessor :date_of_retirement
  attr_accessor :date_of_peerage_announcement
  attr_accessor :date_of_introduction
  attr_accessor :date_of_writ
  attr_accessor :lords_membership_types
  attr_accessor :lords_oaths
  
  # Method to construct a date range for house membership.
  def house_membership_period
    house_membership_period = ''
    house_membership_period += self.house_start_date.strftime( '%e %B %Y' ) if self.house_start_date
    house_membership_period += ' - '
    house_membership_period += self.house_end_date.strftime( '%e %B %Y' ) if self.house_end_date
    house_membership_period
  end

  def full_title?
    full_title.blank? ? "<!-- no full_title -->".html_safe : full_title.to_s.html_safe
  end

  def laying_minister_name?
    laying_minister_name.blank? ? "<!-- no laying_minister_name -->".html_safe : laying_minister_name
  end

  def party?
    party.blank? ? "<!-- no party -->".html_safe : party.to_s.html_safe
  end

  def house_membership_period?
    (house_start_date or house_end_date) ? house_membership_period : "<!-- no house_membership_period -->".html_safe
  end

  def date_of_death?
     date_of_death ? date_of_death.strftime( '%e %B %Y') : "<!-- no date_of_death -->".html_safe
  end

  def house?
    house ? house : "<!-- no house -->".html_safe
 end

def membership_status_text?
 membership_status_text.blank? ? "<!-- no membership_status_text -->".html_safe : membership_status_text
end

def membership_status_reason?
  membership_status_reason.blank? ? "<!-- no membership_status_reason -->".html_safe : membership_status_reason
 end

 def membership_status_start_date?
  membership_status_start_date ? membership_status_start_date.strftime( '%e %B %Y' ) : "<!-- no membership_status_start_date -->".html_safe
end

def constituency?
  constituency ? constituency : "<!-- no constituency -->".html_safe
end

def lords_membership_type?
  lords_membership_type ? lords_membership_type : "<!-- no lords_membership_type -->".html_safe
end

def members_api
  JSON.load(open("https://members-api.parliament.uk/api/Members/" + mnis_id.text))
end

end
