require "spec_helper"

class Rails
  # mock Rails
end

describe UniformNotifier::RailsLogger do
  it "should not notify rails logger" do
    UniformNotifier::RailsLogger.out_of_channel_notify(:title => "notify rails logger").should be_nil
  end

  it "should notify rails logger" do
    logger = double("logger")
    Rails.should_receive(:logger).and_return(logger)
    logger.should_receive(:warn).with("notify rails logger")

    UniformNotifier.rails_logger = true
    UniformNotifier::RailsLogger.out_of_channel_notify(:title => "notify rails logger")
  end
end
