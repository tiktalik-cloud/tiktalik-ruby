# Description of an operation that was performed on an Instance.
# Used purely for informative purposes.
module Tiktalik
  module Computing
    class Operation < Object

      attr_reader :uuid,       # String
                  :start_time, # Date
                  :end_time,   # Date
                  :description # String

    end
  end
end
