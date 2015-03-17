require "spec_helper"

class Rollbar
  # mock Rollbar
end

describe UniformNotifier::RollbarNotifier do
  it "should not notify rollbar" do
    UniformNotifier::RollbarNotifier.out_of_channel_notify(:title => "notify rollbar").should be_nil
  end

  it "should notify rollbar" do
    Rollbar.should_receive(:info).with(UniformNotifier::Exception.new("notify rollbar"))

    UniformNotifier.rollbar = true
    UniformNotifier::RollbarNotifier.out_of_channel_notify(:title => "notify rollbar")
  end
end
