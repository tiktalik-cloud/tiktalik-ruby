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

    end
  end
end
