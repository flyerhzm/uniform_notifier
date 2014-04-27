require 'spec_helper'

describe UniformNotifier::Xmpp do
  it "should not notify xmpp" do
    UniformNotifier::Xmpp.out_of_channel_notify(:title => "notify xmpp").should be_nil
  end

  it "should notify xmpp without online status" do
    jid = double("jid")
    xmpp = double("xmpp")
    Jabber::JID.should_receive(:new).with('from@gmail.com').and_return(jid)
    Jabber::Client.should_receive(:new).with(jid).and_return(xmpp)
    xmpp.should_receive(:connect)
    xmpp.should_receive(:auth).with('123456')

    message = double("message")
    Jabber::Message.should_receive(:new).with('to@gmail.com', 'notify xmpp').and_return(message)
    message.should_receive(:set_type).with(:normal).and_return(message)
    message.should_receive(:set_subject).with('Uniform Notifier').and_return(message)
    xmpp.should_receive(:send).with(message)

    UniformNotifier.xmpp = {:account => 'from@gmail.com', :password => '123456', :receiver => 'to@gmail.com', :show_online_status => false}
    UniformNotifier::Xmpp.out_of_channel_notify(:title => 'notify xmpp')
  end

  it "should notify xmpp with online status" do
    jid = double("jid")
    xmpp = double("xmpp")
    Jabber::JID.should_receive(:new).with('from@gmail.com').and_return(jid)
    Jabber::Client.should_receive(:new).with(jid).and_return(xmpp)
    xmpp.should_receive(:connect)
    xmpp.should_receive(:auth).with('123456')

    presence = double("presence")
    now = Time.now
    Time.stub(:now).and_return(now)
    Jabber::Presence.should_receive(:new).and_return(presence)
    presence.should_receive(:set_status).with("Uniform Notifier started on #{now}").and_return(presence)
    xmpp.should_receive(:send).with(presence)

    message = double("message")
    Jabber::Message.should_receive(:new).with('to@gmail.com', 'notify xmpp').and_return(message)
    message.should_receive(:set_type).with(:normal).and_return(message)
    message.should_receive(:set_subject).with('Uniform Notifier').and_return(message)
    xmpp.should_receive(:send).with(message)

    UniformNotifier.xmpp = {:account => 'from@gmail.com', :password => '123456', :receiver => 'to@gmail.com', :show_online_status => true}
    UniformNotifier::Xmpp.out_of_channel_notify(:title => 'notify xmpp')
  end
end
