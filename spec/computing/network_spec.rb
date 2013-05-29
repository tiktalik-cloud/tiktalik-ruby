require 'spec_helper'

describe Tiktalik::Computing::Network do

  context ".all" do
    let(:url) { "/api/v1/computing/network" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::Network.method(:all) }

    it "should return empty array if no networks found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(0)
    end

    it "should return array with networks if some networks found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[{},{}]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(2)
      results.each do |result|
        result.class.should eql(Tiktalik::Computing::Network)
      end
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 500'
  end

  context ".create" do
    let(:url) { "/api/v1/computing/network" }
    let(:method) { :post }
    let(:request) { Tiktalik::Computing::Network.method(:create) }
    let(:default_params) {{ :name => "test" }}

    it_should_behave_like 'require parameters', [:name]

    it "should create network" do
      $faraday_stubs.send(method, url) { [ 200, {}, '{}' ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Network)
    end

    it "shuld wrap network parameters" do
      $faraday_stubs.send(method, url) { [ 200, {}, MultiJson.dump(NETWORK_STUB) ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Network)
      result.uuid.should eql("e92e60c2-2993-4a0c-b635-c5e2b2462c7a")
    end

    it_should_behave_like 'support error 400'
    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 500'
  end

  context ".find" do
    let(:url) { "/api/v1/computing/network/123" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::Network.method(:find) }
    let(:default_params) {"123"}

    it "should return network" do
      $faraday_stubs.send(method, url) { [ 200, {}, '{}' ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Network)
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 404'
  end

  context "instance" do
    let(:subject) { Tiktalik::Computing::Network.new(NETWORK_STUB)}

    its(:uuid) { should eql("e92e60c2-2993-4a0c-b635-c5e2b2462c7a") }
    its(:name) { should eql("pub2") }
    its(:net) { should eql("37.233.98.0/24") }
    its(:owner) { should eql("system") }
    its(:domainname) { should eql("p2.tiktalik.com") }
    its(:public) { should eql(true) }
  end
end
