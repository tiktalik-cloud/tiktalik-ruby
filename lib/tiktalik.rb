module Tiktalik

  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Computing, "#{ROOT}/tiktalik/computing"
  autoload :Object,    "#{ROOT}/tiktalik/object"
  autoload :VERSION,   "#{ROOT}/tiktalik/version"

end
