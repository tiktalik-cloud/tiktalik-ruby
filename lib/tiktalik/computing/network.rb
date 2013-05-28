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
        results = request(:get, '/computing/network')
        results.collect { |result| new(result) }
      end

      # Create private network.
      #
      # @param [Hash] params Params for network
      #
      # @option params [String] :name Network name - as part of local domain(required)
      def self.create(params = {})
        require_params(params, :name)
        result = request(:post, '/computing/network', params)
        new(result)
      end

      # Get network.
      #
      # @param [String] uuid UUID of network
      def self.find(uuid)
        result = request(:get, "/computing/network/#{uuid}")
        new(result)
      end

    end
  end
end
