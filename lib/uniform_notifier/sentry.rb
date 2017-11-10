class UniformNotifier
  class SentryNotifier < Base
    def self.active?
      !!UniformNotifier.sentry
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      if UniformNotifier.sentry.is_a?(Hash)
        opt = UniformNotifier.sentry
      end

      exception = Exception.new(message)
      Raven.capture_exception(exception, opt)
    end
  end
end
