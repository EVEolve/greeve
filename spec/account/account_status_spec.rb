vcr_opts = {
  cassette_name: "account/account_status",
}

describe Greeve::Account::AccountStatus, vcr: vcr_opts do
  let(:key) { "1515664" }
  let(:vcode) { "QYYBHdsFMmdWjc9bkWhqqKx00NLqA1c3pNHlacqHUGpaTkrnyrzwZ0vFY9L6aei3" }

  let(:resource) { Greeve::Account::AccountStatus.new(key: key, vcode: vcode) }

  context "resource" do
    subject { resource }

    its(:paid_until) { should eq Time.parse("2017-07-10 19:34:28 UTC") }
    its(:create_date) { should eq Time.parse("2010-01-27 02:53:00 UTC") }
    its(:logon_count) { should eq 1336 }
    its(:logon_minutes) { should eq 79004 }

    its(:multi_character_training) { should be_a Greeve::Rowset }
  end

  context "multi_character_training" do
    subject { resource.multi_character_training.first }

    its(:training_end) { should eq Time.parse("2016-10-05 19:54:38 UTC") }
  end
end
