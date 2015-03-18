require 'pry'
module UniformNotifier
  class HTMLLogger < Base
    @logger = nil

    def self.active?
      @logger
    end

    def self._out_of_channel_notify( data )
      message = data.values.compact.join("\n")
      @logger.warn message
    end

    def self.setup(logdev)
      require 'logger'

      @logger = Logger.new( logdev )

      def @logger.format_message( severity, timestamp, progname, msg )
        "<h1>Bullet HTML Log</h1><h2>Timestamp:</h2><p style='margin-left: 1em'>#{timestamp.strftime("%Y-%m-%d %H:%M:%S")}<p><h2>Severity:</h2><p style='margin-left: 1em'>[#{severity}]</p><h2>Message:</h2><p style='margin-left: 1em'>#{msg}</p>"
      end
    end
  end
end
