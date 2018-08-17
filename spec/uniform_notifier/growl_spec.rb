# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UniformNotifier::Growl do
  it 'should not notify growl' do
    expect(UniformNotifier::Growl.out_of_channel_notify(title: 'notify growl')).to be_nil
  end

  it 'should notify growl without password' do
    growl = double('growl', is_a?: true)
    expect(Growl).to receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    expect(growl).to receive(:add_notification).with('uniform_notifier')
    expect(growl).to receive(:password=).with(nil)
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl without password').ordered

    UniformNotifier.growl = true
    UniformNotifier::Growl.out_of_channel_notify(title: 'notify growl without password')
  end

  it 'should notify growl with password' do
    growl = double('growl', is_a?: true)
    expect(Growl).to receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    expect(growl).to receive(:add_notification).with('uniform_notifier')
    expect(growl).to receive(:password=).with('123456')
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password').ordered

    UniformNotifier.growl = { password: '123456' }
    UniformNotifier::Growl.out_of_channel_notify(title: 'notify growl with password')
  end

  it 'should notify growl with host' do
    growl = double('growl', is_a?: true)
    expect(Growl).to receive(:new).with('10.10.156.17', 'uniform_notifier').and_return(growl)
    expect(growl).to receive(:add_notification).with('uniform_notifier')
    expect(growl).to receive(:password=).with('123456')
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on').ordered
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password').ordered

    UniformNotifier.growl = { password: '123456', host: '10.10.156.17' }
    UniformNotifier::Growl.out_of_channel_notify(title: 'notify growl with password')
  end

  it 'should notify growl with quiet' do
    growl = double('growl', is_a?: true)
    expect(Growl).to receive(:new).with('localhost', 'uniform_notifier').and_return(growl)
    expect(growl).to receive(:add_notification).with('uniform_notifier')
    expect(growl).to receive(:password=).with('123456')
    expect(growl).not_to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'Uniform Notifier Growl has been turned on')
    expect(growl).to receive(:notify).with('uniform_notifier', 'Uniform Notifier', 'notify growl with password')

    UniformNotifier.growl = { password: '123456', quiet: true }
    UniformNotifier::Growl.out_of_channel_notify(title: 'notify growl with password')
  end
end
