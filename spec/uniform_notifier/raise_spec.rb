require "spec_helper"

describe UniformNotifier::Raise do
  it "should not notify message" do
    UniformNotifier::Raise.inline_notify("notification").should be_nil
  end

  it "should raise error of the default class" do
    UniformNotifier.raise = true
    expect {
      UniformNotifier::Raise.inline_notify("notification")
    }.to raise_error(UniformNotifier::Raise::UniformNotifierException, "notification")
  end

  it "allows the user to override the default exception class" do
    klass = Class.new(Exception)
    UniformNotifier.raise = klass
    expect {
      UniformNotifier::Raise.inline_notify("notification")
    }.to raise_error(klass, "notification")
  end

  it "can be turned from on to off again" do
    UniformNotifier.raise = true
    UniformNotifier.raise = false

    expect {
      UniformNotifier::Raise.inline_notify("notification")
    }.not_to raise_error
  end
end
