describe Greeve::Config do
  subject { Greeve::Config }

  it "is a singleton" do
    expect { Greeve::Config.new }.to raise_error NoMethodError
  end

  context "user_agent" do
    let(:user_agent) { "Test Application" }

    it { should respond_to :user_agent }
    it { should respond_to :user_agent= }

    it "can be set" do
      subject.user_agent.should_not eq user_agent

      subject.user_agent = user_agent
      subject.user_agent.should eq user_agent
    end
  end
end
