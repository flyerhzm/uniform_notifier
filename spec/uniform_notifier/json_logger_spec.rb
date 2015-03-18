require "spec_helper"
require "json"

describe UniformNotifier::JSONLogger do
  it "should not notify to customized logger" do
    UniformNotifier::CustomizedLogger.out_of_channel_notify(:title => "notify json logger").should be_nil
  end

  it "should notify to customized logger" do
    logger = File.open( 'test.json', 'a+' )
    logger.sync = true

    now = Time.now
    Time.stub(:now).and_return(now)
    UniformNotifier.json_logger = logger
    UniformNotifier::JSONLogger.out_of_channel_notify(:title => "notify json logger")

    logger.seek(0)

    formatted = {
      "timestamp" => "#{now.strftime("%Y-%m-%d %H:%M:%S")}",
      "severity" => "WARN",
      "msg" => "notify json logger"
    }
    logger.read.should ==  formatted.to_json
    File.delete('test.json')
  end
end