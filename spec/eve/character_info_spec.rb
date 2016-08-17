describe Greeve::Eve::CharacterInfo do
  let(:response_file) { "public_character_info" }
  let(:character_id) { 462421468 }

  before {
    stub_endpoint(
      "#{Greeve::EVE_API_BASE_URL}/eve/CharacterInfo.xml.aspx?characterID=#{character_id}",
      response_file
    )

    invalidate_remaining_endpoints
  }

  subject { Greeve::Eve::CharacterInfo.new(character_id) }

  its(:character_id) { should eq character_id }
  its(:character_name) { should eq "Zaphoon" }
  its(:race) { should eq "Caldari" }
  its(:bloodline_id) { should eq 2 }
  its(:bloodline) { should eq "Civire" }
  its(:ancestry_id) { should eq 7 }
  its(:ancestry) { should eq "Entrepreneurs" }
  its(:corporation_id) { should eq 98063277 }
  its(:corporation) { should eq "Archon Corporation" }
  its(:corporation_date) { should eq "2016-07-24 02:57:00" }
  its(:security_status) { should eq BigDecimal.new("2.40297246280317") }
end
