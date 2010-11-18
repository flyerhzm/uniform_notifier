require 'spec_helper'

describe UniformNotifier::Growl do
  
  it "should notify growl without password" do
    UniformNotifier.growl = true
    p UniformNotifier::Growl.out_of_channel_notify('notify growl without password').methods.sort
  end
end