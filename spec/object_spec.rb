require 'spec_helper'
require 'timecop'
require 'time'

describe Tiktalik::Object do
  before do
    Timecop.freeze(Time.parse("Wed, 29 May 2013 10:21:20 GMT" ))
  end

  after do
    Timecop.return
  end

  context ".request" do
    it "should have valid content type header set" do
      $faraday_stubs.get("/api/v1/test", { "content-type" => 'application/x-www-form-urlencoded' }) { [200, {}, '']}
      Tiktalik::Object.send(:request, :get, "/test")
      $faraday_stubs.verify_stubbed_calls
    end

    it "should have valid date header set" do
      $faraday_stubs.get("/api/v1/test", { "date" => "Wed, 29 May 2013 10:21:20 GMT"  }) { [200, {}, '']}
      Tiktalik::Object.send(:request, :get, "/test")
      $faraday_stubs.verify_stubbed_calls
    end

    it "should have valid authorization header set" do
      $faraday_stubs.get("/api/v1/test", { "Authorization" => "TKAuth API_KEY:is1EXmnDaRYNouQSHu5Wu36ZYg8="  }) { [200, {}, '']}
      Tiktalik::Object.send(:request, :get, "/test")
      $faraday_stubs.verify_stubbed_calls
    end
  end
end
