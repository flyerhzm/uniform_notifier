module UniformNotifier
  class AirbrakeNotifier < Base
    def self.active?
      UniformNotifier.airbrake
    end

    def self.out_of_channel_notify(message)
      return unless active?
      exception = Exception.new(message)
      Airbrake.notify(exception)
    end
  end
end
