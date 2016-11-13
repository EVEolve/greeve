vcr_opts = {
  cassette_name: "eve/character_info",
}

vcr_opts_match_any = {
  cassette_name: "eve/character_info",
  match_requests_on: [],
  allow_playback_repeats: true,
}

vcr_opts_response_error = {
  cassette_name: "response_error_404",
  match_requests_on: [],
  allow_playback_repeats: true,
}

vcr_opts_namespace_dsl = {
  cassette_name: "corporation/starbase_detail",
}

describe Greeve::BaseItem, vcr: vcr_opts do
  let(:character_id)  { 462421468 }
  let(:character_name) { "Zaphoon" }

  it "is an abstract class" do
    expect { Greeve::BaseItem.new(character_id) }.to raise_error(TypeError)
  end

  context "subclassed" do
    let(:subclass) {
      Class.new(Greeve::BaseItem).tap do |klass|
        klass.class_eval do
          endpoint "eve/CharacterInfo"

          attribute :character_id,     xpath: "eveapi/result/characterID/?[0]",     type: :integer
          attribute :character_name,   xpath: "eveapi/result/characterName/?[0]",   type: :string
          attribute :corporation_date, xpath: "eveapi/result/corporationDate/?[0]", type: :datetime
          attribute :security_status,  xpath: "eveapi/result/securityStatus/?[0]",  type: :numeric
          attribute :does_not_exist,   xpath: "does_not_exist/?[0]",                type: :string

          def initialize(character_id)
            super(query_params: {"characterID" => character_id})
          end
        end
      end
    }

    let(:api_item) { subclass.new(character_id) }
    subject { api_item }

    describe "ResponseError", vcr: vcr_opts_response_error do
      subject {
        begin
          api_item
        rescue Greeve::ResponseError => ex
          ex
        end
      }

      it "is raised" do
        expect { api_item }.to raise_error(Greeve::ResponseError)
      end

      its(:code) { should eq 404 }
      its(:status_message) { should eq "Not Found" }
      its(:message) { should eq "404 Not Found" }
    end

    describe "DSL" do
      let(:subclass) {
        Class.new(Greeve::BaseItem).tap do |klass|
          klass.class_eval do
            def initialize(character_id)
              super(query_params: {"characterID" => character_id})
            end
          end
        end
      }

      describe "endpoint", vcr: vcr_opts_match_any do
        specify do
          subclass.class_eval do
            endpoint "test/endpoint"
          end

          subject.__send__(:endpoint).should eq "test/endpoint"
        end

        specify "shouldn't start with a slash" do
          expect {
            subclass.class_eval do
              endpoint "/test/endpoint"
            end
          }.to raise_error ArgumentError
        end
      end

      describe "attribute" do
        before {
          _character_name_xpath = "eveapi/result/characterName/?[0]"

          subclass.class_eval do
            endpoint "eve/CharacterInfo"

            attribute :character_name, xpath: _character_name_xpath, type: :string
          end
        }

        its(:character_name) { should eq character_name }

        it "is registered" do
          subject.send(:_attributes).keys.should include :character_name
        end
      end

      describe "namespace", vcr: vcr_opts_namespace_dsl do
        let(:item_id) { 100449451 }
        let(:key) { 1515664 }
        let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

        let(:subclass) {
          Class.new(Greeve::BaseItem).tap do |klass|
            klass.class_eval do
              endpoint "corp/StarbaseDetail"

              namespace :general_settings, xpath: "eveapi/result/generalSettings" do
                attribute :usage_flags, xpath: "usageFlags/?[0]", type: :integer
              end

              namespace :combat_settings, xpath: "eveapi/result/combatSettings" do
                namespace :use_standings_from, xpath: "useStandingsFrom" do
                  attribute :owner_id, xpath: "@ownerID", type: :integer
                end
              end

              def initialize(item_id, opts = {})
                opts[:query_params] = {"itemID" => item_id}
                super(opts)
              end
            end
          end
        }

        let(:api_item) { subclass.new(item_id, key: key, vcode: vcode) }
        subject { namespace }

        it "is registered as an attribute" do
          api_item.send(:_attributes).keys.should include :general_settings
          api_item.send(:_attributes).keys.should include :combat_settings
        end

        specify(:to_h) do
          api_item.to_h.should eq ({
            general_settings: {
              usage_flags: 3,
            },
            combat_settings: {
              use_standings_from: {
                owner_id: 154683985,
              },
            },
          })
        end

        describe "general_settings" do
          let(:namespace) { api_item.general_settings }

          it { should be_a Greeve::Namespace }
          its(:name) { should eq :general_settings }
          its(:usage_flags) { should eq 3 }
        end

        describe "combat_settings" do
          let(:namespace) { api_item.combat_settings }

          it { should be_a Greeve::Namespace }
          its(:name) { should eq :combat_settings }
          its(:use_standings_from) { should be_a Greeve::Namespace }

          describe "use_standings_from" do
            let(:namespace) { api_item.combat_settings.use_standings_from }

            it { should be_a Greeve::Namespace }
            its(:name) { should eq :use_standings_from }
            its(:owner_id) { should eq 154683985 }
          end
        end
      end

      describe "rowset" do
        let(:rowset) { api_item.employment_history }
        subject { rowset }

        before {
          subclass.class_eval do
            endpoint "eve/CharacterInfo"

            rowset :employment_history, xpath: "eveapi/result/rowset[@name='employmentHistory']" do
              attribute :record_id,        xpath: "@recordID",        type: :integer
              attribute :corporation_id,   xpath: "@corporationID",   type: :integer
              attribute :corporation_name, xpath: "@corporationName", type: :string
              attribute :start_date,       xpath: "@startDate",       type: :datetime
            end
          end
        }

        specify "is registered as an attribute" do
          api_item.send(:_attributes).keys.should include :employment_history
        end

        it { should be_a Greeve::Rowset }
        its(:name) { should eq :employment_history }

        its(:to_a) do
          should eq [
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
    end

    describe "cache_expired?", vcr: vcr_opts_match_any do
      before {
        # Replace `cachedUntil` with a mocked value.
        subject.instance_variable_get(:@xml_element).tap do |xml|
          xml.locate("eveapi/cachedUntil").first.tap do |e|
            e.nodes.clear
            e << cached_until.to_s.gsub(/ UTC$/, "")
          end
        end
      }

      describe "returns true if cache time is in the past" do
        let(:cached_until) { (Time.now - 3600).utc }

        its(:cache_expired?) { should be true }
        its(:refresh) { should be true }
      end

      describe "returns false if cache time is in the future" do
        let(:cached_until) { (Time.now + 3600).utc }

        its(:cache_expired?) { should be false }
        its(:refresh) { should be false }
      end
    end

    its(:inspect) do
      should include subject.object_id.to_s
      should include "character_name: #{character_name}"
      should include "corporation_date: 2016-07-24 02:57:00 UTC"
      should include "security_status: 2.40297246280317"
    end

    its(:to_s) do
      should include "character_name: #{character_name}"
    end

    its(:to_h) do
      should eq({
        character_id: character_id,
        character_name: "Zaphoon",
        corporation_date: Time.parse("2016-07-24 02:57:00 UTC"),
        security_status: BigDecimal.new("2.40297246280317"),
      })
    end
  end
end
