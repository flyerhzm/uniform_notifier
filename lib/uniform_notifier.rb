require 'uniform_notifier/base'
require 'uniform_notifier/javascript_alert'
require 'uniform_notifier/javascript_console'
require 'uniform_notifier/growl'
require 'uniform_notifier/xmpp'
require 'uniform_notifier/rails_logger'

module UniformNotifier
  class NotificationError < StandardError; end

  class <<self
    attr_accessor :alert, :console, :growl, :rails_logger, :xmpp

    def growl=(growl)
      UniformNotifier::Growl.setup_connection(growl)
    end

    def xmpp=(xmpp)
      UniformNotifier::Growl.setup_connection(xmpp)
    end
  end
end
