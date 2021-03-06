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
        request(:delete, "/computing/instance/#{@instance_uuid}/interface/#{@uuid}")
        true
      end

      private

      def after_initialize
        @network = Network.new(@network) if @network
      end

    end
  end
end
