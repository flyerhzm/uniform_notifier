# frozen_string_literal: true

class UniformNotifier
  class SentryNotifier < Base
    def self.active?
      !!UniformNotifier.sentry
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      opt = UniformNotifier.sentry if UniformNotifier.sentry.is_a?(Hash)

      exception = Exception.new(message)
      Raven.capture_exception(exception, opt)
    end
  end
end
