require 'spec_helper'

describe Tiktalik::Computing::VPSImage do

  context ".all" do
    let(:url) { "/api/v1/computing/image" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::VPSImage.method(:all) }

    it "should return empty array if no images found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(0)
    end

    it "should return array with images if some images found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[{},{}]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(2)
      results.each do |result|
        result.class.should eql(Tiktalik::Computing::VPSImage)
      end
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 500'
  end

  context ".find" do
    let(:url) { "/api/v1/computing/image/123" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::VPSImage.method(:find) }
    let(:default_params) {"123"}

    it "should return image" do
      $faraday_stubs.send(method, url) { [ 200, {}, '{}' ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::VPSImage)
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 404'
    it_should_behave_like 'support error 500'
  end

  context "instance" do
    let(:subject) { Tiktalik::Computing::VPSImage.new(VPSIMAGE_STUB)}

    its(:uuid) { should eql("e18aee6c-9548-457e-9c20-7103d454969a") }
    its(:name) { should eql("Centos 6.4 64-bit") }
    its(:owner) { should eql("system") }
    its(:type) { should eql("image") }
    its(:is_public) { should eql(true) }
    its(:description) { should eql("Some description") }
    its(:create_time) { should eql(Time.parse("2013-03-25 15:29:51 +0100 (UTC)")) }

    context "#destroy" do
      let(:url) { "/api/v1/computing/image/#{subject.uuid}" }
      let(:method) { :delete }
      let(:request) { subject.method(:destroy) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 404'
      it_should_behave_like 'support error 500'
    end

  end
end
