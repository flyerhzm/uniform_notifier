# frozen_string_literal: true

class UniformNotifier
  class Xmpp < Base
    @receiver = nil
    @xmpp = nil
    @password = nil

    def self.active?
      @xmpp
    end

    def self.setup_connection(xmpp_information)
      return unless xmpp_information

      require 'xmpp4r'

      @xmpp = xmpp_information
      @receiver = xmpp_information[:receiver]
      @password = xmpp_information[:password]
      @account  = xmpp_information[:account]
      @show_online_status = xmpp_information[:show_online_status]
      @stay_connected = xmpp_information[:stay_connected].nil? ? true : xmpp_information[:stay_connected]

      connect if @stay_connected
    rescue LoadError
      @xmpp = nil
      raise NotificationError, 'You must install the xmpp4r gem to use XMPP notification: `gem install xmpp4r`'
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      notify(message)
    end

    private

    def self.connect
      jid = Jabber::JID.new(@account)
      @xmpp = Jabber::Client.new(jid)
      @xmpp.connect
      @xmpp.auth(@password)
      @xmpp.send(presence_status) if @show_online_status
    end

    def self.notify(message)
      connect unless @stay_connected
      message = Jabber::Message.new(@receiver, message)
                               .set_type(:normal)
                               .set_subject('Uniform Notifier')
      @xmpp.send(message)
    end

    def self.presence_status
      Jabber::Presence.new.set_status("Uniform Notifier started on #{Time.now}")
    end
  end
end
