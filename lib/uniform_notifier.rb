require 'uniform_notifier/base'
require 'uniform_notifier/errors'
require 'uniform_notifier/javascript_alert'
require 'uniform_notifier/javascript_console'
require 'uniform_notifier/growl'
require 'uniform_notifier/xmpp'
require 'uniform_notifier/rails_logger'
require 'uniform_notifier/customized_logger'
require 'uniform_notifier/airbrake'
require 'uniform_notifier/bugsnag'
require 'uniform_notifier/slack'
require 'uniform_notifier/raise'
require 'uniform_notifier/json_logger'
require 'uniform_notifier/html_logger'

module UniformNotifier
  class NotificationError < StandardError; end

  class <<self
    attr_accessor :alert, :console, :growl, :rails_logger, :xmpp, :airbrake, :bugsnag, :slack, :raise, :json_logger, :html_logger

    NOTIFIERS = [JavascriptAlert, JavascriptConsole, Growl, Xmpp, RailsLogger, CustomizedLogger, AirbrakeNotifier, BugsnagNotifier, Raise, Slack, JSONLogger, HTMLLogger]

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

    def json_logger=(logdev)
      UniformNotifier::JSONLogger.setup(logdev)
    end

    def html_logger=(logdev)
      UniformNotifier::HTMLLogger.setup(logdev)
    end

    def slack=(slack)
      UniformNotifier::Slack.setup_connection(slack)
    end

    def raise=(exception_class)
      UniformNotifier::Raise.setup_connection(exception_class)
    end
  end
end
