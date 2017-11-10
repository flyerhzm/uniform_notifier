require 'uniform_notifier/base'
require 'uniform_notifier/errors'
require 'uniform_notifier/javascript_alert'
require 'uniform_notifier/javascript_console'
require 'uniform_notifier/growl'
require 'uniform_notifier/honeybadger'
require 'uniform_notifier/xmpp'
require 'uniform_notifier/rails_logger'
require 'uniform_notifier/customized_logger'
require 'uniform_notifier/airbrake'
require 'uniform_notifier/sentry'
require 'uniform_notifier/rollbar'
require 'uniform_notifier/bugsnag'
require 'uniform_notifier/slack'
require 'uniform_notifier/raise'

class UniformNotifier
  AVAILABLE_NOTIFIERS = [:alert, :console, :growl, :honeybadger, :xmpp, :rails_logger,
                         :customized_logger, :airbrake, :rollbar, :bugsnag, :slack, :raise,
                         :sentry
                        ]

  NOTIFIERS = [JavascriptAlert, JavascriptConsole, Growl, HoneybadgerNotifier, Xmpp, RailsLogger,
               CustomizedLogger, AirbrakeNotifier, RollbarNotifier, BugsnagNotifier, Raise, Slack,
               SentryNotifier
              ]

  class NotificationError < StandardError; end

  class <<self
    attr_accessor(*AVAILABLE_NOTIFIERS)

    def active_notifiers
      NOTIFIERS.select { |notifier| notifier.active? }
    end

    undef :growl=
    def growl=(growl)
      UniformNotifier::Growl.setup_connection(growl)
    end

    undef :xmpp=
    def xmpp=(xmpp)
      UniformNotifier::Xmpp.setup_connection(xmpp)
    end

    undef :customized_logger=
    def customized_logger=(logdev)
      UniformNotifier::CustomizedLogger.setup(logdev)
    end

    undef :slack=
    def slack=(slack)
      UniformNotifier::Slack.setup_connection(slack)
    end

    undef :raise=
    def raise=(exception_class)
      UniformNotifier::Raise.setup_connection(exception_class)
    end
  end
end
