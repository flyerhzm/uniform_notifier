# frozen_string_literal: true

require "spec_helper"

class Bugsnag
  # mock Bugsnag
end

RSpec.describe UniformNotifier::BugsnagNotifier do
  let(:notification_data) { {} }
  it "should not notify bugsnag" do
    expect(Bugsnag).not_to receive(:notify)
    UniformNotifier::BugsnagNotifier.out_of_channel_notify(notification_data)
  end
  context "with string notification" do
    let(:notification_data) { {:user => 'user', :title => 'notify bugsnag', :url => 'URL', body: 'something'} }

    it "should notify bugsnag" do
      expect(Bugsnag).to receive(:notify).with(UniformNotifier::Exception.new(notification_data[:title]), :grouping_hash => notification_data[:body], :notification => notification_data)

      UniformNotifier.bugsnag = true
      UniformNotifier::BugsnagNotifier.out_of_channel_notify(notification_data)
    end

    it "should notify bugsnag with option" do
      expect(Bugsnag).to receive(:notify).with(UniformNotifier::Exception.new(notification_data[:title]), :foo => :bar, :grouping_hash => notification_data[:body], :notification => notification_data)

      UniformNotifier.bugsnag = { :foo => :bar }
      UniformNotifier::BugsnagNotifier.out_of_channel_notify(notification_data)
    end
  end
  context "with hash notification" do
    let(:notification_data) { "notify bugsnag" }

    it "should notify bugsnag" do
      expect(Bugsnag).to receive(:notify).with(UniformNotifier::Exception.new("notify bugsnag"), :grouping_hash => "notify bugsnag", :notification => {:title => "notify bugsnag"})

      UniformNotifier.bugsnag = true
      UniformNotifier::BugsnagNotifier.out_of_channel_notify(notification_data)
    end

    it "should notify bugsnag with option" do
      expect(Bugsnag).to receive(:notify).with(UniformNotifier::Exception.new("notify bugsnag"), :foo => :bar, :grouping_hash => "notify bugsnag", :notification => {:title => "notify bugsnag"})

      UniformNotifier.bugsnag = { :foo => :bar }
      UniformNotifier::BugsnagNotifier.out_of_channel_notify(notification_data)
    end
  end

  it "should notify bugsnag with correct backtrace" do
    expect(Bugsnag).to receive(:notify) do |error|
      expect(error).to be_a UniformNotifier::Exception
      expect(error.backtrace).to eq ["bugsnag spec test"]
    end
    UniformNotifier.bugsnag = true
    UniformNotifier::BugsnagNotifier.out_of_channel_notify(backtrace: ["bugsnag spec test"])
  end
end
