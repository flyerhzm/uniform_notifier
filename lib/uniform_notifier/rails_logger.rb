module UniformNotifier
  class RailsLogger < Base
    def self.active?
      UniformNotifer.rails_logger
    end

    def self.out_of_channel_notify( notice )
      return unless active?
      Rails.logger.warn ''
      Rails.logger.warn notice.full_notice
    end
  end
end