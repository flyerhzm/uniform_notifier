require "spec_helper"

describe UniformNotifier::JavascriptAlert do
  it "should not notify message" do
    UniformNotifier::JavascriptAlert.inline_notify(:title => "javascript alert!").should be_nil
  end

  it "should notify message" do
    UniformNotifier.alert = true
    UniformNotifier::JavascriptAlert.inline_notify(:title => "javascript alert!").should == <<-CODE
<script type="text/javascript">/*<![CDATA[*/
alert( "javascript alert!" );
/*]]>*/</script>
CODE
  end
end
