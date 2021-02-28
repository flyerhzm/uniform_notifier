# frozen_string_literal: true

require 'spec_helper'

class Appsignal
  # mock AppSignal
end

RSpec.describe UniformNotifier::AppsignalNotifier do
  it 'should not notify appsignal' do
    expect(UniformNotifier::AppsignalNotifier.out_of_channel_notify(title: 'notify appsignal')).to be_nil
  end

  it 'should notify appsignal with keyword title' do
    expect(Appsignal).to receive(:send_error).with(UniformNotifier::Exception.new('notify appsignal'), {})

    UniformNotifier.appsignal = true
    expect(UniformNotifier::AppsignalNotifier.out_of_channel_notify(title: 'notify appsignal'))
  end

  it 'should notify appsignal with first argument title' do
    expect(Appsignal).to receive(:send_error).with(UniformNotifier::Exception.new('notify appsignal'), {})

    UniformNotifier.appsignal = true
    UniformNotifier::AppsignalNotifier.out_of_channel_notify('notify appsignal')
  end

  it 'should notify appsignal with tags' do
    expect(Appsignal).to receive(:send_error).with(UniformNotifier::Exception.new('notify appsignal'), { foo: :bar })

    UniformNotifier.appsignal = true
    UniformNotifier::AppsignalNotifier.out_of_channel_notify(title: 'notify appsignal', tags: { foo: :bar })
  end

  it 'should notify appsignal with default namespace' do
    expect(Appsignal).to receive(:send_error).with(UniformNotifier::Exception.new('notify appsignal'), {}, 'web')

    UniformNotifier.appsignal = { namespace: 'web' }
    UniformNotifier::AppsignalNotifier.out_of_channel_notify('notify appsignal')
  end

  it 'should notify appsignal with overridden namespace' do
    expect(Appsignal).to receive(:send_error).with(
      UniformNotifier::Exception.new('notify appsignal'),
      { foo: :bar },
      'background'
    )

    UniformNotifier.appsignal = { namespace: 'web' }
    UniformNotifier::AppsignalNotifier.out_of_channel_notify(
      title: 'notify appsignal',
      tags: {
        foo: :bar
      },
      namespace: 'background'
    )
  end

  it 'should notify appsignal with merged tags' do
    expect(Appsignal).to receive(:send_error).with(
      UniformNotifier::Exception.new('notify appsignal'),
      { user: 'Bob', hostname: 'frontend2', site: 'first' },
      'background'
    )

    UniformNotifier.appsignal = { namespace: 'web', tags: { hostname: 'frontend1', user: 'Bob' } }
    UniformNotifier::AppsignalNotifier.out_of_channel_notify(
      title: 'notify appsignal',
      tags: {
        hostname: 'frontend2',
        site: 'first'
      },
      namespace: 'background'
    )
  end
end
