require 'rspec'
require 'tiktalik'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    # Everything is stubbed so we just need to set it to constant
    Tiktalik.api_key = "API_KEY"
    Tiktalik.api_secret_key = "API_SECRET_KEY"

    # Stub all requests
    $faraday_stubs = Faraday::Adapter::Test::Stubs.new
    Tiktalik::Object.adapter.adapter :test, $faraday_stubs
  end

  config.before(:each) do
    # Remove previously used stubs
    $faraday_stubs.instance_variable_set("@stack", {})
    $faraday_stubs.instance_variable_set("@consumed", {})
  end
end
