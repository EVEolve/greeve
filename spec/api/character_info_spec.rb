describe Greeve::API::CharacterInfo do
  let(:character_xml) {
    load_xml_file("public_character_info", xpath: "result")
  }

  subject { Greeve::API::CharacterInfo.new(character_xml) }

  its(:character_id) do
    should eq character_xml.locate("characterID/?[0]").first.to_i
  end

  its(:character_name) do
    should eq character_xml.locate("characterName/?[0]").first
  end

  its(:race) do
    should eq character_xml.locate("race/?[0]").first
  end

  its(:bloodline_id) do
    should eq character_xml.locate("bloodlineID/?[0]").first.to_i
  end

  its(:bloodline) do
    should eq character_xml.locate("bloodline/?[0]").first
  end

  its(:ancestry_id) do
    should eq character_xml.locate("ancestryID/?[0]").first.to_i
  end

  its(:ancestry) do
    should eq character_xml.locate("ancestry/?[0]").first
  end

  its(:corporation_id) do
    should eq character_xml.locate("corporationID/?[0]").first.to_i
  end

  its(:corporation) do
    should eq character_xml.locate("corporation/?[0]").first
  end

  its(:corporation_date) do
    should eq character_xml.locate("corporationDate/?[0]").first
  end

  its(:security_status) do
    should eq character_xml.locate("securityStatus/?[0]").first.to_f
  end
end
