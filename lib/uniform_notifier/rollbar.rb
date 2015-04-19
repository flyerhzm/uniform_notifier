class UniformNotifier
  class RollbarNotifier < Base
    def self.active?
      !!UniformNotifier.rollbar
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      exception = Exception.new(message)
      Rollbar.info(exception)
    end
  end
end
