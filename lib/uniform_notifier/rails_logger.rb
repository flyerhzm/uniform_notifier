class UniformNotifier
  class RailsLogger < Base
    def self.active?
      UniformNotifier.rails_logger
    end

    protected

    def self._out_of_channel_notify( data )
      message = data.values.compact.join("\n")

      Rails.logger.warn message
    end
  end
end
