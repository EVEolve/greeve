describe Greeve do
  describe "EVE_API_BASE_URL" do
    subject { Greeve::EVE_API_BASE_URL }

    it { should be_a String }
    it { should_not be_empty }
  end
end
