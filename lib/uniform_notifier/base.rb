module UniformNotifier
  class Base
    def self.active?
      false
    end
    
    def wrap_js_association( message )
      %{ 
        <script type="text/javascript">/*<![CDATA[*/
        #{message}
        /*]]>*/</script>
      }
    end
  end
end