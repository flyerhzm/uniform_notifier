# frozen_string_literal: true

class UniformNotifier
  class Raise < Base
    def self.active?
      @exception_class
    end

    def self.setup_connection(exception_class)
      @exception_class = exception_class == true ? Exception : exception_class
    end

    protected

    def self._out_of_channel_notify(data)
      message = data.values.compact.join("\n")

      raise @exception_class, message
    end
  end
end
