module Tiktalik

  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Computing, "#{ROOT}/tiktalik/computing"
  autoload :Object,    "#{ROOT}/tiktalik/object"
  autoload :VERSION,   "#{ROOT}/tiktalik/version"

  def self.base_url; 'https://www.tiktalik.com'; end
  def self.base_path; '/api/v1'; end

  def self.api_key; @api_key || ENV['API_KEY']; end
  def self.api_key=(val); @api_key = val; end

  def self.api_secret_key; @api_secret_key || ENV['API_SECRET_KEY']; end
  def self.api_secret_key=(val); @api_secret_key = val; end

end
