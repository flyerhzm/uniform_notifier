class UniformNotifier
  class TerminalNotifier < Base
    def self.active?
      !!UniformNotifier.terminal_notifier
    end

    protected

    def self._out_of_channel_notify( data )
      begin
        require 'terminal-notifier'
      rescue LoadError
        raise NotificationError.new( 'You must install the terminal-notifier gem to use terminal_notifier: `gem install terminal-notifier`' )
      end

      ::TerminalNotifier.notify(data[:body], :title => data[:title])
    end
  end
end
