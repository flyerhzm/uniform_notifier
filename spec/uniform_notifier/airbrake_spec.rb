require "spec_helper"

class Airbrake
  # mock Airbrake
end

describe UniformNotifier::AirbrakeNotifier do
  it "should not notify airbrake" do
    UniformNotifier::AirbrakeNotifier.out_of_channel_notify("notify airbrake").should be_nil
  end

  it "should notify airbrake" do
    Airbrake.should_receive(:notify).with(Exception.new("notify airbrake"))

    UniformNotifier.airbrake = true
    UniformNotifier::AirbrakeNotifier.out_of_channel_notify("notify airbrake")
  end
end
