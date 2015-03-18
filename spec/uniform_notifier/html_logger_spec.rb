require "spec_helper"

describe UniformNotifier::HTMLLogger do
  it "should not notify to html logger" do
    UniformNotifier::HTMLLogger.out_of_channel_notify(:title => "notify html logger").should be_nil
  end

  it "should notify to html logger" do
    logger = File.open( 'test.html', 'a+' )
    logger.sync = true

    now = Time.now
    Time.stub(:now).and_return(now)
    UniformNotifier.html_logger = logger
    UniformNotifier::HTMLLogger.out_of_channel_notify(:title => "notify html logger")

    logger.seek(0)
    logger.read.should == "<h1>Bullet HTML Log</h1><h2>Timestamp:</h2><p style='margin-left: 1em'>#{now.strftime("%Y-%m-%d %H:%M:%S")}<p><h2>Severity:</h2><p style='margin-left: 1em'>[WARN]</p><h2>Message:</h2><p style='margin-left: 1em'>notify html logger</p>"
    File.delete('test.html')
  end
end
