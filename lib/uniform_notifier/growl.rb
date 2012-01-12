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
      @password = growl.instance_of?(Hash) ? growl[:password] : nil
      @growl = ::Growl.new('localhost',
                           'uniform_notifier',
                           [ 'uniform_notifier' ],
                           nil,
                           @password)

      notify 'Uniform Notifier Growl has been turned on'
    end

    def self.setup_connection_growl( growl )
      return unless growl
      require 'ruby_gntp'
      @password = growl.instance_of?(Hash) ? growl[:password] : nil
      @growl = GNTP.new('uniform_notifier', 'localhost', @password, 23053)
      @growl.register({:notifications => [{
                                            :name     => 'uniform_notifier',
                                            :enabled  => true,
                                          }]})

      notify 'Uniform Notifier Growl has been turned on (using GNTP)'
    end

    private
      def self.notify( message )
        case @growl
        when Growl
          @growl.notify( 'uniform_notifier', 'Uniform Notifier', message )
        when GNTP
          @growl.notify({
                          :name  => 'uniform_notifier',
                          :title => 'Uniform Notifier',
                          :text  => message
                        })
        end
      end
    end
  end
