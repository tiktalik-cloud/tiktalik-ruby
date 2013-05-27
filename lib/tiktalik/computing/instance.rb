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

    end
  end
end
