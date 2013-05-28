module Tiktalik
  class Error < RuntimeError

    class BadRequest < Tiktalik::Error
      def status; 400; end
    end

    class Unauthorized < Tiktalik::Error
      def status; 401; end
    end

    class PaymentRequired < Tiktalik::Error
      def status; 402; end
    end

    class Forbidden < Tiktalik::Error
      def status; 403; end
    end

    class NotFound < Tiktalik::Error
      def status; 404; end
    end

    class NotAllowed < Tiktalik::Error
      def status; 405; end
    end

    class Conflict < Tiktalik::Error
      def status; 409; end
    end

    class ServerError < Tiktalik::Error
      def status; 500; end
    end

    class UnknownStatus < Tiktalik::Error
      def status; 500; end
    end

    STATUSES = {
      400 => BadRequest,
      401 => Unauthorized,
      402 => PaymentRequired,
      403 => Forbidden,
      404 => NotFound,
      405 => NotAllowed,
      409 => Conflict,
      500 => ServerError
    }

    def self.find_by_status(status)
      STATUSES[status.to_i] || UnknownStatus
    end

  end
end
