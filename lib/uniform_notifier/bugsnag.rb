module UniformNotifier
  class BugsnagNotifier < Base
    def self.active?
      !!UniformNotifier.bugsnag
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      if UniformNotifier.bugsnag.is_a?(Hash)
        opt = UniformNotifier.bugsnag
      end

      exception = Exception.new(message)
      Bugsnag.notify(exception, opt)
    end
  end
end
