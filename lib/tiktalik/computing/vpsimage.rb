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
                  :create_time  # Date

      # List of VPS images.
      def self.all
      end

      # Get image or backup.
      def self.find(uuid)
      end

      # Delete users backup image.
      def destroy
      end

    end
  end
end
