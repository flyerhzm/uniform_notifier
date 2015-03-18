require 'json'

module UniformNotifier
  class JSONLogger < Base
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
        formatted = { "timestamp" => "#{timestamp.strftime("%Y-%m-%d %H:%M:%S")}",
        "severity" => "#{severity}",
        "msg" => "#{msg}" }
        formatted.to_json
      end
    end
  end
end