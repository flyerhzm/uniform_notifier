require "spec_helper"

describe UniformNotifier::CustomizedLogger do
  it "should not notify to customized logger" do
    UniformNotifier::CustomizedLogger.out_of_channel_notify(:title => "notify rails logger").should be_nil
  end

  it "should notify to customized logger" do
    logger = File.open( 'test.log', 'a+' )
    logger.sync = true

    now = Time.now
    Time.stub(:now).and_return(now)
    UniformNotifier.customized_logger = logger
    UniformNotifier::CustomizedLogger.out_of_channel_notify(:title => "notify rails logger")

    logger.seek(0)
    logger.read.should == "#{now.strftime("%Y-%m-%d %H:%M:%S")}[WARN] notify rails logger"

    File.delete('test.log')
  end
end
