require "spec_helper"

class Bugsnag
  # mock Bugsnag
end

describe UniformNotifier::BugsnagNotifier do
  it "should not notify bugsnag" do
    UniformNotifier::BugsnagNotifier.out_of_channel_notify("notify bugsnag").should be_nil
  end

  it "should notify bugsnag" do
    Bugsnag.should_receive(:notify).with(Exception.new("notify bugsnag"))

    UniformNotifier.bugsnag = true
    UniformNotifier::BugsnagNotifier.out_of_channel_notify("notify bugsnag")
  end
end
