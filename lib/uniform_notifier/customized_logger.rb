class UniformNotifier
  class CustomizedLogger < Base
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
        "#{timestamp.strftime("%Y-%m-%d %H:%M:%S")}[#{severity}] #{msg}"
      end
    end
  end
end
