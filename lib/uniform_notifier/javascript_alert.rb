module UniformNotifier
  class JavascriptAlert < Base
    def self.active?
      UniformNotifer.alert
    end

    def self.inline_notify( notice )
      return '' unless self.active?

      wrap_js_association "alert( #{notice.standard_notice.inspect} ); "
    end
  end
end