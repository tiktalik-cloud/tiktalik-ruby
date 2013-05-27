# A network interface attached to an Instance. Maps directly to a network interface
# visible from the operating system's point.
module Tiktalik
  module Computing
    class VPSNetInterface < Object

      attr_reader :uuid,    # String
                  :network, # Network
                  :mac,     # String
                  :ip,      # String
                  :seq      # Fixnum - interface sequence number: 0 for eth0, 1 for eth1, etc.

      # Remove virtual machine network interface.
      def destroy
      end

    end
  end
end
