# Represents a user's Instance. This object is used to perform mission-critical
# operations like stopping or starting an instance. Note that you should never
# construct this object yourself; use a ComputingConnection to fetch instances
# from the server.
module Tiktalik
  module Computing
    class Instance < Object

      attr_reader :uuid,               # String
                  :hostname,           # String
                  :owner,              # String
                  :vpsimage_uuid,      # String
                  :state,              # Fixnum
                  :running,            # Boolean
                  :networks,           # Array(VPSNetInterface)
                  :actions,            # Array(Operation)
                  :vpsimage,           # VPSImage
                  :default_password,   # String
                  :service_name,       # String
                  :gross_cost_per_hour # Float

      # List of user virtual machines.
      def self.all
      end

      # Create a new virtual machine.
      def self.create
      end

      # Get virtual machine details.
      def self.find(uuid)
      end

      # Delete instance.
      def destroy
      end

      # List of instance network interfaces.
      def interfaces
      end

      # Create virtual machine network interface.
      def build_interface
      end

      # Call "Install" operation on virtual machine.
      def install
      end

      # Call "Boot" or "Start" operation on virtual machine.
      def start
      end

      # Call "Shutdown" operation on virtual machine.
      def stop
      end

      # Force "Shutdown" operation on virtual machine.
      def force_stop
      end

      # Do "Backup" of virtual machine. VPS need to be stopped in order to create its backup.
      def backup
      end

    end
  end
end
