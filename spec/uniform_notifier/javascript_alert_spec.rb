require "spec_helper"

describe UniformNotifier::JavascriptAlert do
  it "should notify message" do
    UniformNotifier.alert = true
    UniformNotifier::JavascriptAlert.inline_notify("javascript alert!").should == <<-CODE
<script type="text/javascript">/*<![CDATA[*/
alert( "javascript alert!" );
/*]]>*/</script>
CODE
  end
end