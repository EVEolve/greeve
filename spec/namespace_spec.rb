describe Greeve::Namespace do
  let(:xml_element) {
    load_xml_from_cassette("corporation/starbase_detail")
      .locate("eveapi/result/generalSettings")
      .first
  }

  let(:namespace_block) {
    proc {
      attribute :usage_flags,               xpath: "usageFlags/?[0]",              type: :integer
      attribute :deploy_flags,              xpath: "deployFlags/?[0]",             type: :integer
      attribute :allow_corporation_members, xpath: "allowCorporationMembers/?[0]", type: :boolean
      attribute :allow_alliance_members,    xpath: "allowAllianceMembers/?[0]",    type: :boolean
    }
  }

  let(:namespace_name) { :general_settings }
  let(:namespace) {
    Greeve::Namespace.new(namespace_name, xml_element, &namespace_block)
  }

  subject { namespace }

  specify "DSL helper methods are disabled after initialization" do
    expect { subject.attribute }.to raise_error NoMethodError
    expect { subject.namespace }.to raise_error NoMethodError
  end

  its(:to_h) do
    should eq ({
      usage_flags: 3,
      deploy_flags: 0,
      allow_corporation_members: true,
      allow_alliance_members: true,
    })
  end

  describe "to_s" do
    subject { namespace.to_s }

    specify do
      subject.should include "#{namespace_name}"

      subject.should include "usage_flags: 3"
      subject.should include "deploy_flags: 0"
      subject.should include "allow_corporation_members: true"
      subject.should include "allow_alliance_members: true"
    end
  end

  describe "inspect" do
    subject { namespace.inspect }

    specify do
      subject.should include namespace.class.to_s
      subject.should include namespace.object_id.to_s
      subject.should include "name: #{namespace_name}"

      subject.should include "usage_flags: 3"
      subject.should include "deploy_flags: 0"
      subject.should include "allow_corporation_members: true"
      subject.should include "allow_alliance_members: true"
    end
  end
end
