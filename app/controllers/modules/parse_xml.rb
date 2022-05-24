# # Module to parse the XML response from the public MNIS API.
module PARSE_XML
  
  # ## Method to parse the XML response from the public MNIS API.
  def parse_xml( doc )
    
    # For each member returned in the record set ...
    doc.xpath( "//Member" ).each do |node|
      
      # ... we create a new member object ...
      member = Member.new
      
      # ... and populate the member object with core data properties - those returned by default for every record.
      
      # Identifiers.
      member.mnis_id = node.xpath( "@Member_Id" )
      member.dods_id = node.xpath( "@Dods_Id" )
      member.pims_id = node.xpath( "@Pims_Id" )
      member.clerks_id = node.xpath( "@Clerks_Id" )
      
      # Names.
      member.display_as = node.xpath( "DisplayAs/text()" )
      member.list_as = node.xpath( "ListAs/text()" )
      member.full_title = node.xpath( "FullTitle/text()" )
      member.laying_minister_name = node.xpath( "LayingMinisterName/text()" )
      
      # Personal details.
      member.date_of_death = node.xpath( "DateOfDeath/text()" ).text.to_date
      if node.xpath( "Gender/text()" ).text == 'F'
        member.gender = 'Female'
      elsif node.xpath( "Gender/text()" ).text == 'M'
        member.gender = 'Male'
      end
      
      # House details.
      if node.xpath( "House/text()" ).text == 'Commons'
        member.house = 'House of Commons'
        member.constituency = node.xpath( "MemberFrom/text()" )
      elsif node.xpath( "House/text()" ).text == 'Lords'
        member.house = 'House of Lords'
        member.lords_membership_type = node.xpath( "MemberFrom/text()" )
      end
      member.house_start_date = node.xpath( "HouseStartDate/text()" ).text.to_date
      member.house_end_date = node.xpath( "HouseEndDate/text()" ).text.to_date
      member.membership_status_active = node.xpath( "CurrentStatus/@IsActive" )
      member.membership_status_text = node.xpath( "CurrentStatus/Name/text()" )
      member.membership_status_reason = node.xpath( "CurrentStatus/Reason/text()" )
      member.membership_status_start_date = node.xpath( "CurrentStatus/StartDate/text()" ).text.to_date
      
      # Party details.
      member.party = node.xpath( "Party/text()" )
      
      # We populate the member object with any additional information we chose to include.
      member.maiden_speeches = []
      node.xpath( "MaidenSpeeches/MaidenSpeech" ).each do |node|
        maiden_speech = []
        maiden_speech[0] = node.xpath( "House/text()" )
        maiden_speech[1] = node.xpath( "SpeechDate/text()" ).text.to_date
        maiden_speech[2] = node.xpath( "Hansard/text()" )
        maiden_speech[3] = node.xpath( "Subject/text()" )
        member.maiden_speeches << maiden_speech
        puts maiden_speech[2]
        puts maiden_speech[3]
      end
      
      member.addresses = []
      node.xpath( "Addresses/Address" ).each do |node|
        address = []
        address[0] = node.xpath( "Type/text()" )
        address[1] = node.xpath( "IsPreferred/text()" )
        address[2] = node.xpath( "IsPhysical/text()" )
        address[3] = node.xpath( "Note/text()" )
        address[4] = node.xpath( "Address1/text()" )
        address[5] = node.xpath( "Address2/text()" )
        address[6] = node.xpath( "Address3/text()" )
        address[7] = node.xpath( "Address4/text()" )
        address[8] = node.xpath( "Address5/text()" )
        address[9] = node.xpath( "Postcode/text()" )
        address[10] = node.xpath( "Phone/text()" )
        address[11] = node.xpath( "Fax/text()" )
        address[12] = node.xpath( "Email/text()" )
        member.addresses << address
      end
      
      member.constituencies = []
      node.xpath( "Constituencies/Constituency" ).each do |node|
        constituency = []
        constituency[0] = node.xpath( "@Id" )
        constituency[1] = node.xpath( "Name/text()" )
        constituency[2] = node.xpath( "StartDate/text()" ).text.to_date
        constituency[3] = node.xpath( "EndDate/text()" ).text.to_date
        constituency[4] = node.xpath( "Election/@Id" )
        constituency[5] = node.xpath( "Election/Name/text()" )
        constituency[6] = node.xpath( "Election/Date/text()" ).text.to_date
        constituency[7] = node.xpath( "Election/Type/text()" )
        constituency[8] = node.xpath( "EndReason/text()" )
        constituency[9] = node.xpath( "EntryType/text()" )
        constituency[10] = node.xpath( "Notes/text()" )
        constituency[11] = node.xpath( "SwearInOrder/text()" )
        constituency[12] = node.xpath( "SwornInForename/text()" )
        constituency[13] = node.xpath( "SwornInMiddleNames/text()" )
        constituency[14] = node.xpath( "SwornInSurname/text()" )
        constituency[15] = node.xpath( "SwornInTitle/text()" )
        member.constituencies << constituency
      end
      
      member.parties = []
      node.xpath( "Parties/Party" ).each do |node|
        party = []
        party[0] = node.xpath( "@Id" )
        party[1] = node.xpath( "Name/text()" )
        party[2] = node.xpath( "SubType/text()" )
        party[3] = node.xpath( "StartDate/text()" ).text.to_date
        party[4] = node.xpath( "EndDate/text()" ).text.to_date
        party[5] = node.xpath( "Note/text()" )
        party[6] = node.xpath( "SitsOppositeSideToParty/text()" )
        member.parties << party
      end
      
      member.given_surname = node.xpath( "BasicDetails/GivenSurname/text()" )
      member.given_middle_names = node.xpath( "BasicDetails/GivenMiddleNames/text()" )
      member.given_forename = node.xpath( "BasicDetails/GivenForename/text()" )
      member.given_forename = node.xpath( "BasicDetails/GivenForename/text()" )
      member.town_of_birth = node.xpath( "BasicDetails/TownOfBirth/text()" )
      member.country_of_birth = node.xpath( "BasicDetails/CountryOfBirth/text()" )
      member.date_of_retirement = node.xpath( "BasicDetails/DateOfRetirement/text()" ).text.to_date
      member.date_of_peerage_announcement = node.xpath( "BasicDetails/LordsDetails/DateOfAnnouncement/text()" ).text.to_date
      member.date_of_introduction = node.xpath( "BasicDetails/LordsDetails/DateOfIntroduction/text()" ).text.to_date
      member.date_of_writ = node.xpath( "BasicDetails/LordsDetails/DateOfWrit/text()" ).text.to_date
      
      member.lords_membership_types = []
      node.xpath( "BasicDetails/LordsDetails/MembershipTypes/MembershipType" ).each do |node|
        lords_membership_type = []
        lords_membership_type[0] = node.xpath( "Type/text()" )
        lords_membership_type[1] = node.xpath( "StartDate/text()" ).text.to_date
        lords_membership_type[2] = node.xpath( "EndDate/text()" ).text.to_date
        member.lords_membership_types << lords_membership_type
      end
      
      member.lords_oaths = []
      node.xpath( "BasicDetails/LordsDetails/Oaths/Oath" ).each do |node|
        lords_oath = []
        lords_oath[0] = node.xpath( "Date/text()" ).text.to_date
        member.lords_oaths << lords_oath
      end
      
      # We add the member object to the array of Members.
      @members << member
    end
  end
end