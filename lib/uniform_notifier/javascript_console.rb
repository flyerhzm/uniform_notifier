class UniformNotifier
  class JavascriptConsole < Base
    def self.active?
      UniformNotifier.console
    end

    protected

    def self._inline_notify( data )
      message = data.values.compact.join("\n")

      code = <<-CODE
if (typeof(console) !== 'undefined' && console.log) {
  if (console.groupCollapsed && console.groupEnd) {
    console.groupCollapsed(#{"Uniform Notifier".inspect});
    console.log(#{message.inspect});
    console.groupEnd();
  } else {
    console.log(#{message.inspect});
  }
}
CODE

      wrap_js_association code
    end
  end
end
