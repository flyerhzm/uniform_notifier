require "spec_helper"

describe UniformNotifier::Raise do
  it "should not notify message" do
    UniformNotifier::Raise.inline_notify("notification").should be_nil
  end

  it "should notify message" do
    UniformNotifier.raise = true
    expect {
      UniformNotifier::Raise.inline_notify("notification")
    }.to raise_error(UniformNotifier::Raise::UniformNotifierException, "notification")
  end
end
