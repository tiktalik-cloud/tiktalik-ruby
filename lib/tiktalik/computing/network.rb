# A user- or system-owned network. Each Instance has zero or more networks
# attached, each networking interfaces is represented by a VPSNetInterface
# object.
module Tiktalik
  module Computing
    class Network < Object

      attr_reader :uuid,       # String
                  :name,       # String
                  :net,        # String
                  :owner,      # String
                  :domainname, # String
                  :public      # Boolean

    end
  end
end
