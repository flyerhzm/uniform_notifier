# frozen_string_literal: true

class UniformNotifier
  class AirbrakeNotifier < Base
    def self.active?
      !!UniformNotifier.airbrake
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      opt = UniformNotifier.airbrake if UniformNotifier.airbrake.is_a?(Hash)

      exception = Exception.new(message)
      Airbrake.notify(exception, opt)
    end
  end
end
