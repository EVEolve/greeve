describe Greeve::Eve::CharacterInfo do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:base_endpoint) { "#{Greeve::EVE_API_BASE_URL}/eve/CharacterInfo.xml.aspx" }
  let(:xml_filename) { "public_character_info" }
  let(:character_id) { 462421468 }

  before {
    stub_endpoint(base_endpoint, xml_filename)

    invalidate_remaining_endpoints
  }

  shared_examples :public_info do
    its(:character_id) { should eq character_id }
    its(:character_name) { should eq "Zaphoon" }
    its(:race) { should eq "Caldari" }
    its(:bloodline_id) { should eq 2 }
    its(:bloodline) { should eq "Civire" }
    its(:ancestry_id) { should eq 7 }
    its(:ancestry) { should eq "Entrepreneurs" }
    its(:corporation_id) { should eq 98063277 }
    its(:corporation) { should eq "Archon Corporation" }
    its(:corporation_date) { should eq Time.parse("2016-07-24 02:57:00 UTC") }
    its(:security_status) { should eq BigDecimal.new("2.40297246280317") }

    specify "employment_history" do
      subject.employment_history.to_a.should eq [
        {
          record_id: 42416328,
          corporation_id: 98063277,
          corporation_name: "Archon Corporation",
          start_date: Time.parse("2016-07-24 02:57:00 UTC"),
        },
        {
          record_id: 34716213,
          corporation_id: 1000009,
          corporation_name: "Caldari Provisions",
          start_date: Time.parse("2014-08-25 00:54:00 UTC"),
        },
      ]
    end
  end

  context "public info" do
    subject { Greeve::Eve::CharacterInfo.new(character_id) }

    include_examples :public_info
  end

  context "private info (with api key)" do
    let(:xml_filename) { "public_character_info_with_key" }

    subject { Greeve::Eve::CharacterInfo.new(character_id, key: key, vcode: vcode) }

    include_examples :public_info

    its(:account_balance) { should eq BigDecimal.new("10000000.12") }
    its(:skill_points) { should eq 20_000_000 }
    its(:next_training_ends) { should eq Time.parse("2015-07-22 05:33:56 UTC") }
    its(:ship_name) { should eq "My Ship" }
    its(:ship_type_id) { should eq 24698 }
    its(:ship_type_name) { should eq "Drake" }
    its(:alliance_id) { should eq 99004425 }
    its(:alliance) { should eq "The Bastion" }
    its(:alliance_date) { should eq Time.parse("2014-05-23 02:07:00 UTC") }
    its(:last_known_location) { should eq "Halle II - Caldari Business Tribunal" }
  end
end
