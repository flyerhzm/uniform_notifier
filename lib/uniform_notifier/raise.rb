module UniformNotifier
  class Raise < Base
    class UniformNotifierException < Exception; end

    def self.active?
      UniformNotifier.raise
    end

    def self.inline_notify( message )
      return unless self.active?

      raise UniformNotifierException, message
    end
  end
end
