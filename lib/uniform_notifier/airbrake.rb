class UniformNotifier
  class AirbrakeNotifier < Base
    def self.active?
      !!UniformNotifier.airbrake
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      if UniformNotifier.airbrake.is_a?(Hash)
        opt = UniformNotifier.airbrake
      end

      exception = Exception.new(message)
      Airbrake.notify(exception, opt)
    end
  end
end
