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
                  :interfaces,         # Array(VPSNetInterface)
                  :actions,            # Array(Operation)
                  :vpsimage,           # VPSImage
                  :default_password,   # String
                  :service_name,       # String
                  :gross_cost_per_hour # Float

      # List of user virtual machines.
      #
      # @param [Hash] params Params for results
      #
      # @option params [Boolean] :actions Include list of recent operations if true.
      # @option params [Boolean] :vpsimage Include details about source image if true.
      # @option params [Boolean] :cost Include current cost per hour for each instance if true.
      def self.all(params = {})
        results = request(:get, '/computing/instance', params)
        results.collect { |result| new(result) }
      end

      # Create a new virtual machine.
      #
      # @param [Hash] params Params for instance
      #
      # @option params [String] :image_uuid UID of disk image that should be used(required)
      # @option params [String] :size Size of instance in Units(required)
      # @option params [String] :hostname Hostname set at installation time(required)
      # @option params [Array] :networks Networks to attach, each one as "{uuid}" from Network model.
      def self.create(params = {})
        require_params(params, :image_uuid, :size, :hostname)
        result = request(:post, '/computing/instance', params)
        new(result)
      end

      # Get virtual machine details.
      #
      # @param [String] uuid UUID of instance
      def self.find(uuid)
        result = request(:get, "/computing/instance/#{uuid}")
        new(result)
      end

      # Delete instance.
      def destroy
        request(:delete, "/computing/instance/#{@uuid}")
        true
      end

      # Create virtual machine network interface.
      #
      # @param [Hash] params Params for interface
      #
      # @option params [String] :network_uuid Network UUID. The interface will be assigned an address in this network(required)
      # @option params [String] :seq Interface number, eg. '3' maps to eth3(required)
      def build_interface(params = {})
        require_params(params, :network_uuid, :seq)
        result = request(:post, "/computing/instance/#{@uuid}/interface", params)
        VPSNetInterface.new(result)
      end

      # Call "Install" operation on virtual machine.
      def install
        request(:post, "/computing/instance/#{@uuid}/install")
        true
      end

      # Call "Boot" or "Start" operation on virtual machine.
      def start
        request(:post, "/computing/instance/#{@uuid}/start")
        true
      end

      # Call "Shutdown" operation on virtual machine.
      def stop
        request(:post, "/computing/instance/#{@uuid}/stop")
        true
      end

      # Force "Shutdown" operation on virtual machine.
      def force_stop
        request(:post, "/computing/instance/#{@uuid}/force_stop")
        true
      end

      # Do "Backup" of virtual machine. VPS need to be stopped in order to create its backup.
      def backup
        request(:post, "/computing/instance/#{@uuid}/backup")
        true
      end

      private

      def after_initialize
        @interfaces = [] unless @interfaces.is_a?(Array)
        @interfaces.collect! { |interface| interface.is_a?(VPSNetInterface) ? interface : VPSNetInterface.new(interface.merge(:instance_uuid => @uuid)) }

        @actions = [] unless @actions.is_a?(Array)
        @actions.collect! { |action| action.is_a?(Operation) ? action : Operation.new(action) }

        @vpsimage = VPSImage.new(@vpsimage) if @vpsimage
      end

    end
  end
end
