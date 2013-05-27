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

      # List of available networks.
      def self.all
      end

      # Create private network.
      def self.create
      end

      # Get network.
      def self.find(uuid)
      end

    end
  end
end
