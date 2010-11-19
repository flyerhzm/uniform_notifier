module UniformNotifier
  class JavascriptAlert < Base
    def self.active?
      UniformNotifier.alert
    end

    def self.inline_notify( message )
      return unless self.active?

      wrap_js_association "alert( #{message.inspect} );"
    end
  end
end