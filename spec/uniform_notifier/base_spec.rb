require 'spec_helper'

describe UniformNotifier::Base do
  context "#inline_channel_notify" do
    before do
      UniformNotifier::Base.stub(:active?).and_return(true)
    end
    it "should keep the compatibility" do
      UniformNotifier::Base.should_receive(:_inline_notify).once.with(:title => "something")
      UniformNotifier::Base.inline_notify("something")
    end
  end
  context "#out_of_channel_notify" do
    before do
      UniformNotifier::Base.stub(:active?).and_return(true)
    end
    it "should keep the compatibility" do
      UniformNotifier::Base.should_receive(:_out_of_channel_notify).once.with(:title => "something")
      UniformNotifier::Base.out_of_channel_notify("something")
    end
  end
end
