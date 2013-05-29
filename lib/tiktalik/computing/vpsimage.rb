# Disk image that can be used to create a new instance, or restore one from backup.
module Tiktalik
  module Computing
    class VPSImage < Object

      attr_reader :uuid,        # String
                  :name,        # String
                  :owner,       # String
                  :type,        # String - 'backup', 'image' or 'install'
                  :is_public,   # Boolean
                  :description, # String
                  :create_time  # Time

      # List of VPS images.
      def self.all
        results = request(:get, '/computing/image')
        results.collect { |result| new(result) }
      end

      # Get image or backup.
      #
      # @param [String] uuid UUID of image
      def self.find(uuid)
        result = request(:get, "/computing/image/#{uuid}")
        new(result)
      end

      # Delete users backup image.
      def destroy
        request(:delete, "/computing/image/#{uuid}")
        true
      end

      private

      def after_initialize
        @create_time = Time.parse(@create_time) if @create_time
      end

    end
  end
end
