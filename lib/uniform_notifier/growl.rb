class UniformNotifier
  class Growl < Base
    @growl = nil

    def self.active?
      @growl
    end

    def self.setup_connection( growl )
      setup_connection_growl(growl)
    rescue LoadError
      begin
        setup_connection_gntp(growl)
      rescue LoadError
        @growl = nil
        raise NotificationError.new( 'You must install the ruby-growl or the ruby_gntp gem to use Growl notification: `gem install ruby-growl` or `gem install ruby_gntp`' )
      end
    end

    def self.setup_connection_growl( growl )
      return unless growl
      require 'ruby-growl'
      if growl.instance_of?(Hash)
        @password = growl.include?(:password) ? growl[:password] : nil
        @host = growl.include?(:host) ? growl[:host] : 'localhost'
      end
      @password ||= nil
      @host ||= 'localhost'
      @growl = ::Growl.new @host, 'uniform_notifier'
      @growl.add_notification 'uniform_notifier'
      @growl.password = @password

      notify 'Uniform Notifier Growl has been turned on' if !growl.instance_of?(Hash) || !growl[:quiet]
    end

    def self.setup_connection_gntp( growl )
      return unless growl
      require 'ruby_gntp'
      if growl.instance_of?(Hash)
        @password = growl.include?(:password) ? growl[:password] : nil
        @host = growl.include?(:host) ? growl[:host] : 'localhost'
      end
      @password ||= nil
      @host ||= 'localhost'
      @growl = GNTP.new('uniform_notifier', @host, @password, 23053)
      @growl.register({:notifications => [{
                                            :name     => 'uniform_notifier',
                                            :enabled  => true,
                                          }]})

      notify 'Uniform Notifier Growl has been turned on (using GNTP)' if !growl.instance_of?(Hash) || !growl[:quiet]
    end

    protected

    def self._out_of_channel_notify( data )
      message = data.values.compact.join("\n")

      notify( message )
    end

    private
      def self.notify( message )
        if defined?(::Growl) && @growl.is_a?(::Growl)
          @growl.notify( 'uniform_notifier', 'Uniform Notifier', message )
        elsif defined?(::GNTP) && @growl.is_a?(::GNTP)
          @growl.notify({
                          :name  => 'uniform_notifier',
                          :title => 'Uniform Notifier',
                          :text  => message
                        })
        end
      end
  end
end
