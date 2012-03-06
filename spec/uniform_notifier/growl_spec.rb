require 'spec_helper'

describe UniformNotifier::Growl do

  it "should not notify growl" do
    UniformNotifier::Growl.out_of_channel_notify('notify growl').should be_nil
  end

  it "should notify growl without password" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('localhost', 'uniform_notifier', ['uniform_notifier'], nil, nil).and_return(growl)
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl without password').ordered

    UniformNotifier.growl = true
    UniformNotifier::Growl.out_of_channel_notify('notify growl without password')
  end

  it "should notify growl with password" do
    growl = double('growl', :is_a? => true)
    Growl.should_receive(:new).with('localhost', 'uniform_notifier', ['uniform_notifier'], nil, '123456').and_return(growl)
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    growl.should_receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password').ordered

    UniformNotifier.growl = { :password => '123456' }
    UniformNotifier::Growl.out_of_channel_notify('notify growl with password')
  end
end
