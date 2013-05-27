require 'faraday'
require 'digest/hmac'
require 'base64'
require 'uri'
require 'multi_json'

# Base class for all objects returned by the API.
module Tiktalik
  class Object

    def initialize(json)
      json.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      after_initialize
    end

    private

    def self.adapter
      @adapter ||= Faraday.new(:url => Tiktalik.base_url)
    end

    def self.request(method, path, params = { cost:false, vpsimage:false, actions:false })
      date = Time.now.utc.strftime("%a, %d %b %Y %X GMT")
      url = Tiktalik.base_path + path
      url += "?" + URI.encode_www_form(params) unless params.empty?
      result = adapter.send(method) do |req|
        req.url url
        req.headers['date'] = date
        req.headers['Authorization'] = "TKAuth #{Tiktalik.api_key}:#{auth_key(method, url, req.headers)}"
      end

      raise_error(result.status) unless result.status == 200

      MultiJson.load(result.body)
    end

    def self.auth_key(method, url, headers)
      string_to_sign = [method.to_s.upcase, "", "", headers['date'], url].join("\n")
      Base64.encode64(Digest::HMAC.digest(string_to_sign, Base64.decode64(Tiktalik.api_secret_key), Digest::SHA1)).strip
    end

    def self.raise_error(status)
      raise "Reeceived error status: #{status}"
    end

    def after_initialize
    end

    def request(*args)
      self.class.request *args
    end

  end
end
