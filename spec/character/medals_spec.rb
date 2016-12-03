vcr_opts = {
  cassette_name: "character/medals",
}

describe Greeve::Character::Medals, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }
  let(:character_id) { 462421468 }

  let(:resource) {
    Greeve::Character::Medals.new(character_id, key: key, vcode: vcode)
  }

  context "resource" do
    subject { resource }

    its(:current_corporation) { should be_a Greeve::Rowset }
    its(:other_corporations) { should be_a Greeve::Rowset }
  end

  context "current_corporation" do
    subject { resource.current_corporation.first }

    its(:medal_id) { should eq 95079 }
    its(:reason) { should eq "For continued support, loyalty and dedication towards" }
    its(:status) { should eq "public" }
    its(:issuer_id) { should eq 259695227 }
    its(:issued) { should eq Time.parse("2012-11-19 08:21:17 UTC") }
    its(:corporation_id) { should eq nil }
    its(:title) { should eq nil }
    its(:description) { should eq nil }
  end

  context "other_corporations" do
    subject { resource.other_corporations.first }

    its(:medal_id) { should eq 4106 }
    its(:reason) { should eq "For continued support, loyalty and dedication towards the Centre for Advanced Studies" }
    its(:status) { should eq "private" }
    its(:issuer_id) { should eq 132533870 }
    its(:issued) { should eq Time.parse("2008-11-25 10:36:01 UTC") }
    its(:corporation_id) { should eq 1711141370 }
    its(:title) { should eq "Medal of Service" }
    its(:description) { should eq "For taking initiative and making an extraordinary contribution towards the corporation" }
  end
end
