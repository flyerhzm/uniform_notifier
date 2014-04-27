module UniformNotifier
  class BugsnagNotifier < Base
    def self.active?
      UniformNotifier.bugsnag
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      exception = Exception.new(message)
      Bugsnag.notify(exception)
    end
  end
end
