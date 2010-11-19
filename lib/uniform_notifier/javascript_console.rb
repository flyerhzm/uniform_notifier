module UniformNotifier
  class JavascriptConsole < Base
    def self.active?
      UniformNotifier.console
    end

    def self.inline_notify( message )
      return unless active?

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