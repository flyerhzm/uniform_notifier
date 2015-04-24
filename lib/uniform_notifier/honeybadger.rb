class UniformNotifier
  class HoneybadgerNotifier < Base
    def self.active?
      !!UniformNotifier.honeybadger
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      opt = {}
      if UniformNotifier.honeybadger.is_a?(Hash)
        opt = UniformNotifier.honeybadger
      end

      exception = Exception.new(message)
      Honeybadger.notify(exception, opt)
    end
  end
end
