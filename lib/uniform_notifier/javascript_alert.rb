class UniformNotifier
  class JavascriptAlert < Base
    def self.active?
      UniformNotifier.alert
    end

    protected

    def self._inline_notify( data )
      message = data.values.compact.join("\n")

      wrap_js_association "alert( #{message.inspect} );"
    end
  end
end
