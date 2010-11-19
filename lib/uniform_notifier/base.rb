module UniformNotifier
  class Base
    def self.active?
      false
    end

    def self.wrap_js_association( message )
      <<-CODE
<script type="text/javascript">/*<![CDATA[*/
#{message}
/*]]>*/</script>
      CODE
    end
  end
end