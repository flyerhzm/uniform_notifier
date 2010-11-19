module UniformNotifier
  class RailsLogger < Base
    def self.active?
      UniformNotifier.rails_logger
    end

    def self.out_of_channel_notify( message )
      return unless active?
      Rails.logger.warn message
    end
  end
end