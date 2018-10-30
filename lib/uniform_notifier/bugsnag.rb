# frozen_string_literal: true

class UniformNotifier
  class BugsnagNotifier < Base
    def self.active?
      !!UniformNotifier.bugsnag
    end

    protected

    def self._out_of_channel_notify(data)
      opt = {}
      opt = UniformNotifier.bugsnag if UniformNotifier.bugsnag.is_a?(Hash)

      exception = Exception.new(data[:title])
      exception.set_backtrace(data[:backtrace]) if data[:backtrace]
      Bugsnag.notify(exception, opt.merge(
                                  grouping_hash: data[:body] || data[:title],
                                  notification: data
                                ))
    end
  end
end
