require 'uniform_notifier/base'
require 'uniform_notifier/javascript_alert'
require 'uniform_notifier/javascript_console'
require 'uniform_notifier/growl'
require 'uniform_notifier/xmpp'
require 'uniform_notifier/rails_logger'
require 'uniform_notifier/customized_logger'
require 'uniform_notifier/airbrake'

module UniformNotifier
  class NotificationError < StandardError; end

  class <<self
    attr_accessor :alert, :console, :growl, :rails_logger, :xmpp, :airbrake

    NOTIFIERS = [JavascriptAlert, JavascriptConsole, Growl, Xmpp, RailsLogger, CustomizedLogger, AirbrakeNotifier]

    def active_notifiers
      NOTIFIERS.select { |notifier| notifier.active? }
    end

    def growl=(growl)
      UniformNotifier::Growl.setup_connection(growl)
    end

    def xmpp=(xmpp)
      UniformNotifier::Xmpp.setup_connection(xmpp)
    end

    def customized_logger=(logdev)
      UniformNotifier::CustomizedLogger.setup(logdev)
    end
  end
end
