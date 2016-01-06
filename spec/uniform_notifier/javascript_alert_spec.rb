require "spec_helper"

RSpec.describe UniformNotifier::JavascriptAlert do
  it "should not notify message" do
    expect(UniformNotifier::JavascriptAlert.inline_notify(:title => "javascript alert!")).to be_nil
  end

  it "should notify message" do
    UniformNotifier.alert = true
    expect(UniformNotifier::JavascriptAlert.inline_notify(:title => "javascript alert!")).to eq <<-CODE
<script type="text/javascript">/*<![CDATA[*/
alert( "javascript alert!" );
/*]]>*/</script>
CODE
  end
end
