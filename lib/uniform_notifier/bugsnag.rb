module UniformNotifier
  class BugsnagNotifier < Base
    def self.active?
      UniformNotifier.bugsnag
    end

    def self.out_of_channel_notify(message)
      return unless active?
      exception = Exception.new(message)
      Bugsnag.notify(exception)
    end
  end
end
