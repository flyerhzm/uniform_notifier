require 'spec_helper'

describe UniformNotifier::Growl do

  it "should not notify growl" do
    UniformNotifier::Growl.out_of_channel_notify(:title => 'notify growl').should be_nil
  end

  it "should notify growl without password" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    growl.should_receive(:add_notification).with('uniform_notifier')
    growl.should_receive(:password=).with(nil)
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl without password').ordered

    UniformNotifier.growl = true
    UniformNotifier::Growl.out_of_channel_notify(:title => 'notify growl without password')
  end

  it "should notify growl with password" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    growl.should_receive(:add_notification).with('uniform_notifier')
    growl.should_receive(:password=).with('123456')
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password').ordered

    UniformNotifier.growl = { :password => '123456' }
    UniformNotifier::Growl.out_of_channel_notify(:title => 'notify growl with password')
  end

  it "should notify growl with host" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('10.10.156.17', 'uniform_notifier').and_return(growl)
    growl.should_receive(:add_notification).with('uniform_notifier')
    growl.should_receive(:password=).with('123456')
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password').ordered

    UniformNotifier.growl = { :password => '123456', :host => '10.10.156.17' }
    UniformNotifier::Growl.out_of_channel_notify(:title => 'notify growl with password')
  end

  it "should notify growl with quiet" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    growl.should_receive(:add_notification).with('uniform_notifier')
    growl.should_receive(:password=).with('123456')
    growl.should_not_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on')
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password')

    UniformNotifier.growl = { :password => '123456', :quiet => true }
    UniformNotifier::Growl.out_of_channel_notify(:title => 'notify growl with password')
  end
end
