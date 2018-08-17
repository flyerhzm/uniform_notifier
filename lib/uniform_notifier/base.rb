# frozen_string_literal: true

class UniformNotifier
  class Base
    def self.active?
      false
    end

    def self.inline_notify(data)
      return unless active?

      # For compatibility to the old protocol
      data = { title: data } if data.is_a?(String)

      _inline_notify(data)
    end

    def self.out_of_channel_notify(data)
      return unless active?

      # For compatibility to the old protocol
      data = { title: data } if data.is_a?(String)

      _out_of_channel_notify(data)
    end

    protected

    def self._inline_notify(data); end

    def self._out_of_channel_notify(data); end

    def self.wrap_js_association(code, attributes = {})
      attributes = { type: 'text/javascript' }.merge(attributes || {})
      attributes_string = attributes.map { |k, v| "#{k}=#{v.to_s.inspect}" }.join(' ')

      <<~CODE
        <script #{attributes_string}>/*<![CDATA[*/
        #{code}
        /*]]>*/</script>
      CODE
    end
  end
end
