module UniformNotifier
  class Growl < Base
    @growl = nil

    def self.active?
      @growl
    end

    def self.out_of_channel_notify( message )
      return unless active?
      notify( message )
    end

    def self.setup_connection( growl )
      require 'ruby-growl'
      @password = growl == true ? nil : growl[:password]
      @growl = connect

      notify 'Uniform Notifier Growl has been turned on'
    rescue LoadError
      @growl = nil
      raise NotificationError.new( 'You must install the ruby-growl gem to use Growl notification: `gem install ruby-growl`' )
    end

    private
      def self.connect
        ::Growl.new 'localhost',
                    'uniform_notifier',
                    [ 'uniform_notifier' ],
                    nil,
                    @password
      end

      def self.notify( message )
        @growl.notify( 'uniform_notifier', 'Uniform Notifier', message )
      end
  end
end