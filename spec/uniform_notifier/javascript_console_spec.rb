require "spec_helper"

RSpec.describe UniformNotifier::JavascriptConsole do
  it "should not notify message" do
    expect(UniformNotifier::JavascriptConsole.inline_notify(:title => "javascript console!")).to be_nil
  end

  it "should notify message" do
    UniformNotifier.console = true
    expect(UniformNotifier::JavascriptConsole.inline_notify(:title => "javascript console!")).to eq <<-CODE
<script type="text/javascript">/*<![CDATA[*/
if (typeof(console) !== 'undefined' && console.log) {
  if (console.groupCollapsed && console.groupEnd) {
    console.groupCollapsed(#{"Uniform Notifier".inspect});
    console.log(#{"javascript console!".inspect});
    console.groupEnd();
  } else {
    console.log(#{"javascript console!".inspect});
  }
}

/*]]>*/</script>
    CODE
  end
end
