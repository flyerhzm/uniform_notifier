# frozen_string_literal: true

class UniformNotifier
  class AppsignalNotifier < Base
    class << self
      def active?
        !!UniformNotifier.appsignal
      end

      protected

      def _out_of_channel_notify(data)
        opt = UniformNotifier.appsignal.is_a?(Hash) ? UniformNotifier.appsignal : {}

        exception = Exception.new(data[:title])
        exception.set_backtrace(data[:backtrace]) if data[:backtrace]

        tags = opt.fetch(:tags, {}).merge(data.fetch(:tags, {}))
        namespace = data[:namespace] || opt[:namespace]

        Appsignal.send_error(*[exception, tags, namespace].compact)
      end
    end
  end
end
