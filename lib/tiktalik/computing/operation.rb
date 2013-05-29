# Description of an operation that was performed on an Instance.
# Used purely for informative purposes.
module Tiktalik
  module Computing
    class Operation < Object

      attr_reader :uuid,        # String
                  :start_time,  # Time
                  :end_time,    # Time
                  :description, # String
                  :progress     # Fixnum

      private

      def after_initialize
        @start_time = Time.parse(@start_time) if @start_time
        @end_time = Time.parse(@end_time) if @end_time
      end

    end
  end
end
