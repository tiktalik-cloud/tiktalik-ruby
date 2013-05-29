require 'spec_helper'

describe Tiktalik::Computing::Instance do

  context ".all" do
    let(:url) { "/api/v1/computing/instance" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::Instance.method(:all) }

    it "should return empty array if no instances found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(0)
    end

    it "should return array with instances if some instances found" do
      $faraday_stubs.send(method, url) { [ 200, {}, '[{},{}]' ] }
      results = request.call
      results.class.should eql(Array)
      results.size.should eql(2)
      results.each do |result|
        result.class.should eql(Tiktalik::Computing::Instance)
      end
    end

    it "should accept 'actions' parameter" do
      $faraday_stubs.send(method, url + '?actions=true') { [ 200, {}, '[{},{}]' ] }
      results = request.call(:actions => true)
      results.class.should eql(Array)
      results.size.should eql(2)
      $faraday_stubs.verify_stubbed_calls
    end

    it "should accept 'vpsimage' parameter" do
      $faraday_stubs.send(method, url + '?vpsimage=true') { [ 200, {}, '[{},{}]' ] }
      results = request.call(:vpsimage => true)
      results.class.should eql(Array)
      results.size.should eql(2)
      $faraday_stubs.verify_stubbed_calls
    end

    it "should accept 'cost' parameter" do
      $faraday_stubs.send(method, url + '?cost=true') { [ 200, {}, '[{},{}]' ] }
      results = request.call(:cost => true)
      results.class.should eql(Array)
      results.size.should eql(2)
      $faraday_stubs.verify_stubbed_calls
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 500'
  end

  context ".create" do
    let(:url) { "/api/v1/computing/instance" }
    let(:method) { :post }
    let(:request) { Tiktalik::Computing::Instance.method(:create) }
    let(:default_params) {{ :image_uuid => "123", :size => "0.25", :hostname => "test" }}

    it_should_behave_like 'require parameters', [:image_uuid, :size, :hostname]

    it "should create instance" do
      $faraday_stubs.send(method, url) { [ 200, {}, '{}' ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Instance)
    end

    it "shuld wrap instance parameters" do
      $faraday_stubs.send(method, url) { [ 200, {}, MultiJson.dump(INSTANCE_STUB) ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Instance)
      result.uuid.should eql("71717dfb-3e86-487f-bcf0-01f6856d6bcd")
    end

    it_should_behave_like 'support error 400'
    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 402'
    it_should_behave_like 'support error 403'
    it_should_behave_like 'support error 500'
  end

  context ".find" do
    let(:url) { "/api/v1/computing/instance/123" }
    let(:method) { :get }
    let(:request) { Tiktalik::Computing::Instance.method(:find) }
    let(:default_params) {"123"}

    it "should return instance" do
      $faraday_stubs.send(method, url) { [ 200, {}, '{}' ] }
      result = request.call(default_params)
      result.class.should eql(Tiktalik::Computing::Instance)
    end

    it_should_behave_like 'support error 401'
    it_should_behave_like 'support error 404'
  end

  context "instance" do
    let(:subject) { Tiktalik::Computing::Instance.new(INSTANCE_STUB)}

    its(:uuid) { should eql("71717dfb-3e86-487f-bcf0-01f6856d6bcd")}
    its(:hostname) { should eql("test") }
    its(:owner) { should eql("imanel") }
    its(:vpsimage_uuid) { should eql("e18aee6c-9548-457e-9c20-7103d454969a") }
    its(:state) { should eql(12) }
    its(:running) { should eql(true) }
    its(:default_password) { should eql("c933c94b8b") }
    its(:service_name) { should eql("TC_UNIT_MICRO") }
    its(:gross_cost_per_hour ) { should eql(0.03321) }

    it "should have interfaces" do
      subject.interfaces.class.should eql(Array)
      subject.interfaces.size.should eql(1)
      interface = subject.interfaces.first
      interface.class.should eql(Tiktalik::Computing::VPSNetInterface)
      interface.uuid.should eql("b5a097ee-a095-47b4-b7c7-4b11100559a7")
    end

    it "should have actions" do
      subject.actions.class.should eql(Array)
      subject.actions.size.should eql(1)
      action = subject.actions.first
      action.class.should eql(Tiktalik::Computing::Operation)
      action.uuid.should eql("ad9a7aa3-dc61-4dde-92de-af335a635041")
    end

    it "should have vpsimage" do
      subject.vpsimage.class.should eql(Tiktalik::Computing::VPSImage)
      subject.vpsimage.uuid.should eql("e18aee6c-9548-457e-9c20-7103d454969a")
    end

    context "#destroy" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}" }
      let(:method) { :delete }
      let(:request) { subject.method(:destroy) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 500'
    end

    context "#build_interface" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/interface" }
      let(:method) { :post }
      let(:request) { subject.method(:build_interface) }
      let(:default_params) {{ :network_uuid => "123", :seq => 1 }}

      it_should_behave_like 'require parameters', [:network_uuid, :seq]

      it "should return interface" do
        $faraday_stubs.send(method, url) { [ 200, {}, MultiJson.dump(VPSNETINTERFACE_STUB) ] }
        result = request.call(default_params)
        result.class.should eql(Tiktalik::Computing::VPSNetInterface)
        result.uuid.should eql("b5a097ee-a095-47b4-b7c7-4b11100559a7")
      end

      it_should_behave_like 'support error 400'
      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end

    context "#install" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/install" }
      let(:method) { :post }
      let(:request) { subject.method(:install) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end

    context "#start" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/start" }
      let(:method) { :post }
      let(:request) { subject.method(:start) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end

    context "#stop" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/stop" }
      let(:method) { :post }
      let(:request) { subject.method(:stop) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end

    context "#force_stop" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/force_stop" }
      let(:method) { :post }
      let(:request) { subject.method(:force_stop) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end

    context "#backup" do
      let(:url) { "/api/v1/computing/instance/#{subject.uuid}/backup" }
      let(:method) { :post }
      let(:request) { subject.method(:backup) }

      it "should return true" do
        $faraday_stubs.send(method, url) { [ 200, {}, '' ] }
        request.call.should eql(true)
        $faraday_stubs.verify_stubbed_calls
      end

      it_should_behave_like 'support error 401'
      it_should_behave_like 'support error 403'
      it_should_behave_like 'support error 409'
      it_should_behave_like 'support error 500'
    end
  end
end
