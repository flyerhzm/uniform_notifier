module UniformNotifier
  class CustomizedLogger < Base
    @logger = nil

    def self.active?
      @logger
    end

    def self.out_of_channel_notify( message )
      return unless active?
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
