require 'spec_helper'

describe Tiktalik::Computing::VPSNetInterface do

  context "instance" do
    let(:subject) { Tiktalik::Computing::VPSNetInterface.new(VPSNETINTERFACE_STUB)}

    its(:uuid) { should eql("b5a097ee-a095-47b4-b7c7-4b11100559a7") }
    its(:mac) { should eql("e6:95:e5:4c:99:86") }
    its(:ip) { should eql("37.233.98.178") }
    its(:seq ) { should eql(0) }

    it "should have network" do
      subject.network.class.should eql(Tiktalik::Computing::Network)
      subject.network.uuid.should eql("e92e60c2-2993-4a0c-b635-c5e2b2462c7a")
    end

    context "#destroy" do
      let(:url) { "/api/v1/computing/instance/#{INSTANCE_STUB["uuid"]}/interface/#{subject.uuid}" }
      let(:method) { :delete }
      let(:request) { subject.method(:destroy) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 404'
      it_should_behave_like 'support error 405'
      it_should_behave_like 'support error 500'
    end
  end
end
