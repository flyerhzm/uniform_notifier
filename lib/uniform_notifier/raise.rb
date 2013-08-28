module UniformNotifier
  class Raise < Base
    class UniformNotifierException < Exception; end

    def self.active?
      @exception_class
    end

    def self.inline_notify( message )
      return unless self.active?

      raise @exception_class, message
    end

    def self.setup_connection(exception_class)
      @exception_class = exception_class == true ? UniformNotifierException : exception_class
    end
  end
end
